//
//  LoginController.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit
import JGProgressHUD

protocol AuthnticationDelegate:class {
    func authenticationComplete()
}

class LoginController: UIViewController , UITextFieldDelegate {
    
    //MARK: - propeties
    
    var viewModel = LoginViewModel()
    weak var delegate: AuthnticationDelegate?
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "StartUpLogo").withRenderingMode(.alwaysOriginal)
        iv.tintColor = .white
        return iv
    }()
    
    
    
    private let emailTextField = CustomTextField(placeholder: "איימל")
    private let PasswordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "סיסמא")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    
    private let authButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("התחבר", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16 , weight: .heavy)
        button.addTarget(self, action: #selector(handleLogin), for:.touchUpInside)
        return button 
    
    }()
    
    //MARK: - action button
    @objc func handleLogin(){
        guard let email = emailTextField.text else{return}
        guard let password = PasswordTextField.text else {return}
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "מתחבר"
        hud.show(in: view)
        
        AuthService.LogUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                
                let alert = UIAlertController(title: "שגיאת חיבור", message:"\(error.localizedDescription)" , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "סגירה", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("DENUG: Error login user in \(error.localizedDescription)")
                hud.dismiss()
                return
            }
            hud.dismiss()
            self.delegate?.authenticationComplete()
        }
        
    }
    
    
    
    private let goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: " אין לך חשבון ? ", attributes: [.foregroundColor: UIColor.black , .font:UIFont.boldSystemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "הרשם עכשיו", attributes: [.foregroundColor: UIColor.systemBlue , .font:UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return button
        
    }()
    //MARK: - action button
    @objc func handleShowRegistration(){
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated:true)
        
    }
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
        emailTextField.delegate = self
        PasswordTextField.delegate = self
       
      
    }
    
    //MARK: - helpers
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func configureUI() {
        
        navigationController?.navigationBar.isHidden = true
       
        view.backgroundColor = .white
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 250, width: 250)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,PasswordTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 32, paddingRight: 32)
                                
        
        
    }
    
    func configureTextFieldObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        PasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        
        
    }
    
}


