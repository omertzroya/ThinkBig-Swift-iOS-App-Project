//
//  RegistrationController.swift
//  StartUp
//
//  Created by עומר צרויה on 13/12/2020.
//

import UIKit
import JGProgressHUD




class RegistrationController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {
    
    
    
    //MARK: - propeties
    var checkTrue = false
    var viewModel = RegistrationViewModel()
    weak var delegate: AuthnticationDelegate?
    
    private let selectButtonPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.clipsToBounds = true
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
        
    }()
    
    private let AgreeTerms: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "notagreeTerms"), for: .normal)
        button.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        return button
        
    }()
    
   
    
    //MARK: - actions
    @objc func handleSelectPhoto(){
      let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleAgree(){
        let link = "https://omersr9.wixsite.com/website"
        AgreeTerms.setImage(#imageLiteral(resourceName: "agreeterms"), for: .normal)
        let alert = UIAlertController(title: "תנאי השירות", message:"אני מאשר את תנאי השירות וידוע לי כי אין סובלנות לתוכן פוגעני " , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "לקריאת תנאי השירות ",
                                      style: UIAlertAction.Style.default, handler: {
               (action:UIAlertAction!) -> Void in
                                        UIApplication.shared.open(URL(string: "\(link)")!)
                        
         }))
        alert.addAction(UIAlertAction(title: "מאשר", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      checkTrue = true
        print("Debug \(checkTrue)")
    }
    
    
    
    private var profileImage: UIImage?
    
    private let emailTextField = CustomTextField(placeholder: "איימל")
    private let PasswordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "סיסמא")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let fullNameTextField = CustomTextField(placeholder:"שם מלא")
    
    private let RegistrationButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("הרשם", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16 , weight: .heavy)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    //MARK: - actions
    @objc func handleRegistration() {
        guard let email = emailTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let password = PasswordTextField.text else { return }
        guard let profileImage = profileImage else {  let alert = UIAlertController(title: "שגיאה", message:"נא צרף תמונה " , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "סגירה", style: UIAlertAction.Style.default, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
      
        
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "נא המתן"
        hud.show(in: view)
        
      
      
        if  password.count < 6 {
            let alert = UIAlertController(title: "שגיאה", message:"נא להזמין סיסמא באורך 6 תווים" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "סגירה", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print(email.count)
            hud.dismiss()
        }
       

        
        if email.isValidEmail == false {
            let alert = UIAlertController(title: "שגיאה", message:"נא הזן כתובת איימל תקינה " , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "סגירה", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            hud.dismiss()
        }
        
        
        if email.isEmpty || fullName.isEmpty ||  password.isEmpty == true {
            let alert = UIAlertController(title: "שגיאה", message:"נא מלא את כל השדות המבוקשים" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "סגירה", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            hud.dismiss()
        }
        
        if checkTrue == false {
            let alert = UIAlertController(title: "תנאי שירות", message:"נא אשר את תנאי השירות" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "סגירה", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            hud.dismiss()
            
        }
       
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, profileImage: profileImage)
        AuthService.registerUser(withCredentials: credentials) { [self] error in
            if let error = error {
              
                print("DENUG: Error signin user \(error.localizedDescription)")
                return
            }
            if self.checkTrue == true {
                
                hud.dismiss()
                self.delegate?.authenticationComplete()
                        
        }
            
        
        }
    }
   
    
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "  יש לך כבר חשבון ? ", attributes: [.foregroundColor: UIColor.black , .font:UIFont.boldSystemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "התחבר עכשיו", attributes: [.foregroundColor: UIColor.systemBlue , .font:UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
        
    }()
    //MARK: - action button
    @objc func handleShowLogin(){
        
            navigationController?.popViewController(animated: true)
            
        }
        
            
        
        
        
    
    
    

    
    
    
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //configureUI selectButton photo
        view.addSubview(selectButtonPhoto)
        selectButtonPhoto.setDimensions(height: 275, width: 275)
        selectButtonPhoto.centerX(inView: view)
        selectButtonPhoto.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        // End
        
        configureUI()
        configureTextFieldObservers()
        emailTextField.delegate = self
        PasswordTextField.delegate = self
        fullNameTextField.delegate = self
        
        let stack = UIStackView(arrangedSubviews: [fullNameTextField,emailTextField,PasswordTextField, AgreeTerms ,RegistrationButton] )
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: selectButtonPhoto.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 32, paddingRight: 32)
        
        
        
    }
    
    
    
    //MARK: helpers
  

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func configureUI(){
        
        view.backgroundColor = .systemGray3
        
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image =  info[.originalImage] as? UIImage
        profileImage = image
        selectButtonPhoto.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectButtonPhoto.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectButtonPhoto.layer.borderWidth = 3
        selectButtonPhoto.layer.cornerRadius = 10
        selectButtonPhoto.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        
    }
    
    func configureTextFieldObservers(){
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        PasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == PasswordTextField {
            viewModel.password = sender.text
        }else{
            viewModel.fullName = sender.text
        }
        print("DEBUG: form is vaild \(viewModel.formIsVaild)")
      

     
    }

    
}


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}


