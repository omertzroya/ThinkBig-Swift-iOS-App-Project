//
//  ProfileConroller.swift
//  StartUp
//
//  Created by עומר צרויה on 26/12/2020.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

class ProfileConroller: UIViewController {
    
    
    
    //MARK - Properties
    private let user:User
    
    private lazy var viewModel = ProfileViewModel(user: user)
    
    
    private lazy var collectionView:UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: frame,collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
        
    }()
    
    private let blurView:UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
        
    }()
    
    
    
    
    private let dismissButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal),  for:.normal)
        button.addTarget(self , action: #selector(handaleDismiss), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
       
        return label
        
        
    }()
    private let professionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
        
    }()
    private let bioLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
        
        
    }()
  
    
    //MARK - Lifecycle
    
    
    init(user:User){
        
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG: user is \(user.name)")
        configureUI()
        loadUserDate()
        
        
    }
    
    //MARK - Actions
    
    @objc func handlelike(){
        
    }
    @objc func handleDislike(){
        
    }
    
    @objc func handaleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK - Helpers
    
    
    func loadUserDate(){
        infoLabel.attributedText = viewModel.userDetailsAttributedString
        professionLabel.text = viewModel.MyExperience
        bioLabel.text = viewModel.bio
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(dismissButton)
        dismissButton.setDimensions(height: 60, width: 60)
        dismissButton.anchor(top: collectionView.bottomAnchor , left:view.leftAnchor , paddingTop: -20 , paddingLeft: 16)
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel,professionLabel,bioLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        
        
        view.addSubview(blurView)
        blurView.anchor(top:view.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.topAnchor , right: view.rightAnchor)
        
        
        view.addSubview(infoStack)
        infoStack.anchor(top:collectionView.bottomAnchor , left: view.leftAnchor,right: view.rightAnchor , paddingTop: 12,paddingLeft: 12,paddingRight: 12)
        
     
        
    }
    
   
    
    
    
}

//MARK - UICollectionViewDataSource

extension ProfileConroller: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
       
        cell.imageView.sd_setImage(with: viewModel.imageUrl)
        return cell
    }
    
    
    
}

//MARK - UICollectionViewDelegate


extension ProfileConroller: UICollectionViewDelegate {
    
}

//MARK - UICollectionViewDelegateFlowLayout
extension ProfileConroller:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width + 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
