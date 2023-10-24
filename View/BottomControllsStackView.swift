//
//  HomeNavigationStackView.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit


protocol BottomControllsStackViewDelegate: class {
    
    func handleLike()
    func handleDislike()
    func handleRefresh()
    
    
}


class BottomControllsStackView: UIStackView {
    
    //MARK: - Properties
    
    weak var delegate: BottomControllsStackViewDelegate?
    
    
    let dislikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 130).isActive = true
        distribution = .fillEqually
        
        
        dislikeButton.setImage(#imageLiteral(resourceName: "dislike").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setDimensions(height: 200, width: 70)
        dislikeButton.setDimensions(height: 200, width: 70)
        
        // actions
        
        
        dislikeButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        
        [likeButton,dislikeButton].forEach { view in
            addArrangedSubview(view)
        }
        

        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    
    
    @objc func handleDislike(){
        delegate?.handleDislike()
    }
    @objc func handleLike(){
        delegate?.handleLike()
    }
    
    
    
}

