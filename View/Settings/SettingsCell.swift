//
//  SettingsCell.swift
//  StartUp
//
//  Created by עומר צרויה on 24/12/2020.
//

import UIKit

protocol SettingsCellDelegate: class {
    
    func settingsCell(_ cell: SettingsCell, wantsToUpdateUserWith value:String , for section:SettingsSections)
    
}

class SettingsCell: UITableViewCell , UITextFieldDelegate {
    
    var viewModel:SettingsViewModel!{
        didSet{configure()}
    }
   
    
    // Properties
    
    weak var delegate: SettingsCellDelegate?
    
    lazy var inputField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        
        
        tf.textAlignment = .right
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 20)
        tf.rightView = paddingView
        tf.rightViewMode = .always
        
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        
        return tf
        
    }()
    
    //LifeCycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(inputField)
        inputField.fillSuperview()
        inputField.delegate = self
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Actions
    
    @objc func handleUpdateUserInfo(sender: UITextField){
        
        guard let value = sender.text else {return}
        delegate?.settingsCell(self, wantsToUpdateUserWith: value , for: viewModel.section)
    }
    
    
    
    //Helpers
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }
    
    func configure(){
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
    }
    
    
}
