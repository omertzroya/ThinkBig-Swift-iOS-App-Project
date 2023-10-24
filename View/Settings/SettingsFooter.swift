//
//  SettingsFooter.swift
//  StartUp
//
//  Created by עומר צרויה on 25/12/2020.
//

import UIKit

protocol SettingsFooterDelegate:class {
    func handleLogout()
}

class SettinsFooter: UIView {
    
    
    //MARK - properties
    
    weak var delegate:SettingsFooterDelegate?
    
    private lazy var logoutButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("התנתק", for: .normal)
        button.setTitleColor(.systemRed , for: .normal)
        button.backgroundColor = .systemGray3
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
        
    }()
    
    
    
    //MARK - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spacer = UIView()
        spacer.backgroundColor = .systemGroupedBackground
        
        addSubview(spacer)
        spacer.setDimensions(height: 32, width: frame.width)
        
        addSubview(logoutButton)
        logoutButton.anchor(top:spacer.bottomAnchor, left: leftAnchor , right: rightAnchor , height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK - Actions
    
    @objc func handleLogout() {
        delegate?.handleLogout()
        
    }
    
    
}



