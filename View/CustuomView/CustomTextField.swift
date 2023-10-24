//
//  CustomTextField.swift
//  StartUp
//
//  Created by עומר צרויה on 12/12/2020.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        
        super.init(frame: .zero)
         
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        rightView = spacer
        textAlignment = .right
        rightViewMode = .always
        borderStyle = .none
        textColor = .black
        backgroundColor = .systemGray2
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
        attributedPlaceholder = NSAttributedString(string: placeholder)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
        
    }
    
}
