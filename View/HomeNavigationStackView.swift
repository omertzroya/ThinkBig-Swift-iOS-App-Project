//
//  HomeNavigationStackView.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit

protocol HomeNavigationStackViewDeleget: class {

    func ShowSettings()
    func ShowMessages()
    
}

class HomeNavagationStackView: UIStackView {
    
    
    // MARK: - properties
 
    weak var delegate: HomeNavigationStackViewDeleget?
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let computerIcon = UIImageView(image: #imageLiteral(resourceName: "ThinkBig"))
        
   
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        computerIcon.contentMode = .scaleAspectFill
        
        settingsButton.setImage(#imageLiteral(resourceName: "profilelogo").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), for: .normal)
        
        settingsButton.setDimensions(height: 20, width: 60)
        messageButton.setDimensions(height: 20, width: 70 )
        computerIcon.setDimensions(height:700, width: 700)
        [settingsButton,UIView(),computerIcon,UIView(),messageButton].forEach { view in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        
        settingsButton.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleShowSettings(){
        delegate?.ShowSettings()
    }
    
    @objc func handleShowMessages(){
        delegate?.ShowMessages()
    }
    
    
    
    
    
}
