//
//  AbuseReportController.swift
//  ThinkBig
//
//  Created by עומר צרויה on 07/01/2021.
//

import UIKit
import Firebase

class AbuseReportController: UIViewController , UITextFieldDelegate {
    
    //Properties
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "StartUpLogo").withRenderingMode(.alwaysOriginal)
        iv.tintColor = .white
        return iv
    }()
    
    
    private let reportTextField: UITextField = {
        let tf = CustomTextField(placeholder: "הכנס נימוק על דיווח שימוש לרעה")
        tf.setDimensions(height: 100, width: 100)
        return tf
    }()
    
    private let authButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("דווח", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16 , weight: .heavy)
        button.addTarget(self, action: #selector(handaleReport), for:.touchUpInside)
        return button
    
    }()
    
    
    
    
    
    
    //LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
       
      
        
        
        
   
        
        
        
        
        
    }
    
    //helpers
    
    func configureUI() {
        
        navigationController?.navigationBar.isHidden = true
       
        view.backgroundColor = .white
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 250, width: 250)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [reportTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
       
                                
        
        
    }
    
    
    
    
    
    
    
    //Actions
    
    
    @objc func handaleReport() {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}//End



