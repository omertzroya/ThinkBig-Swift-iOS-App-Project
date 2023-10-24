//
//  SettingsHeader.swift
//  StartUp
//
//  Created by עומר צרויה on 24/12/2020.
//

import UIKit
import SDWebImage

protocol SettingsHeaderDelegate:class  {
    func settingsHeader(_ header:SettingsHeader)
    
    }




class SettingsHeader: UIView{
    
    private let user:User
    
    weak var delegate:SettingsHeaderDelegate?
    lazy var button = configureButton()
  
    
     init(user: User) {
        self.user = user
        super.init(frame: .zero)
        
       
        backgroundColor = .systemGroupedBackground
        
       
        addSubview(button)
        button.anchor(top:topAnchor , left: leftAnchor,bottom: bottomAnchor,right: rightAnchor)
        loadUserPhoto()
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func handleSelectPhoto() {
        
        delegate?.settingsHeader(self)
        
    }
    
    func loadUserPhoto(){
        
        let imageUrl = URL(string: user.profileImageUrl)
       
        SDWebImageManager.shared().loadImage(with: imageUrl, options: .continueInBackground , progress: nil) { (image, _, _, _, _, _) in
            self.button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        
    }
    
    
    func configureButton() -> UIButton {
        
       
        let button = UIButton(type: .system)
        button.setTitle("בחר תמונה", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray2
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
        
    }
    
}


