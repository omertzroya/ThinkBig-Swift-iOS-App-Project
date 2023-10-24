//
//  SettingsController.swift
//  StartUp
//
//  Created by עומר צרויה on 24/12/2020.
//

import UIKit
import JGProgressHUD
import Firebase
import FirebaseFirestore
import SDWebImage

protocol SettingsControllerDelegate:class {
    
    func settingsController(_ controller: SettingsController , wantsToUpdate user:User)
    func SettingsControllerWantsToLogout(_controller: SettingsController)
}

class SettingsController: UITableViewController {
    
    //Properties
    
    
    
    private var user: User
    
    private let footerView = SettinsFooter()
    
    private let reuseIdentifier = "SettingsCell"
     
    private lazy var headerView = SettingsHeader(user: user)
    private let imagePicker = UIImagePickerController()
    
    weak var delegate:SettingsControllerDelegate?
    
    
    
    //LifeCycle
    
    init(user:User) {
        self.user = user
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    
    
    
    
    
    
    //Helpers
    
    @objc func handaleCancle(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handaleDone(){
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "שומר את המידע"
        hud.show(in: view)
   
        view.endEditing(true)
        Service.saveUserDate(user: user) { erorr in
            self.delegate?.settingsController(self, wantsToUpdate: self.user)
        }
       
        
        
     
    }
    
    
    
    func setHeaderImage(_ image:UIImage?){
        headerView.button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func configureUI(){
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        headerView.delegate = self
        imagePicker.delegate = self
        navigationItem.title = "הגדרות פרופיל"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "חזור", style: .plain, target: self, action: #selector(handaleCancle))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "עדכן", style: .plain, target: self, action: #selector(handaleDone))
        
        // line in tableView
        tableView.separatorStyle = .none
        
       
        tableView.tableHeaderView = headerView
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier )
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        tableView.tableFooterView = footerView
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 88)
        footerView.delegate = self
        
    }
    
    
}

// UItableViewDataSorce

extension SettingsController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.allCases.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SettingsCell
        guard let section = SettingsSections(rawValue: indexPath.section) else {return cell}
        let viewModel = SettingsViewModel(user: user, section: section)
        cell.viewModel = viewModel
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = true
        return cell
        
    }
    
}

//UItabaleViewDelegate

extension SettingsController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSections(rawValue: section) else {return nil}
        return section.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}



extension SettingsController:SettingsHeaderDelegate{
    func settingsHeader(_ header: SettingsHeader) {
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SettingsController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    
        let selectedImage = info[.originalImage] as! UIImage
        Service.uploadImage(image: selectedImage) { [self]  imageUrl in
    
            Firestore.firestore().collection("users").document(user.uid).updateData(["imageUrl":imageUrl])
        
        }
        
        setHeaderImage(selectedImage)
        dismiss(animated: true, completion: nil)
        
    }
}

 // MARK: - SettingsCellDelegate
extension SettingsController: SettingsCellDelegate {
    func settingsCell(_ cell: SettingsCell, wantsToUpdateUserWith value: String, for section: SettingsSections) {
        
        switch section {
        
        case .name:
            user.name = value
        case .bio:
            user.bio = value
        case .employer:
            user.employer = value
        case .MyExperience:
            user.MyExperience = value
        case .ExperinceFriend:
            user.ExperinceFriend = value
        case .mode:
            user.mode = value
        
        
        
            
        }
        print("user is \(user)")
    }
}
extension SettingsController:SettingsFooterDelegate {
    func handleLogout() {
        delegate?.SettingsControllerWantsToLogout(_controller: self)
    }
    
    
}
