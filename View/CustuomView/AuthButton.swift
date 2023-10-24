//
//  AuthButton.swift
//  StartUp
//
//  Created by עומר צרויה on 12/12/2020.
//

import UIKit

class AuthButton: UIButton {
    
    
    override  init(frame: CGRect) {
        super.init(frame:frame)
        
        
    
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
