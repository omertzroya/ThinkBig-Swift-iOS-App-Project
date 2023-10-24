//
//  CardViewModel.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit

struct CardViewModel {
    
     let user: User
    
    let imageUrl:URL?
    
    let userInfoText:NSAttributedString
    
    let userInfoText3:NSAttributedString
    let userInfoText4:NSAttributedString
    let userInfoText5:NSAttributedString
    
    init(user: User) {
        
        self.user = user
        
        let atributedText = NSMutableAttributedString(string: user.name , attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy) ,.foregroundColor:UIColor.white])
        atributedText.append(NSAttributedString(string:" \(user.mode)", attributes: [.font:UIFont.systemFont(ofSize: 20) , .foregroundColor:UIColor.white]))
        self.userInfoText = atributedText
        
        
        
        let atributedText3 = NSMutableAttributedString(string: user.employer, attributes: [.font : UIFont.systemFont(ofSize:20) ,.foregroundColor:UIColor.white])
        self.userInfoText3 = atributedText3
        
        let atributedText4 = NSMutableAttributedString(string:user.MyExperience , attributes: [.font : UIFont.systemFont(ofSize:20) ,.foregroundColor:UIColor.white])
        self.userInfoText4 = atributedText4
        
        let atributedText5 = NSMutableAttributedString(string: user.ExperinceFriend , attributes: [.font : UIFont.systemFont(ofSize:20) ,.foregroundColor:UIColor.white])
        self.userInfoText5 = atributedText5
        
        self.imageUrl = URL(string: user.profileImageUrl)
        
    }
    
    
        
        
    
   
    
    
}
