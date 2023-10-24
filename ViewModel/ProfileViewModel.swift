//
//  ProfileViewModel.swift
//  StartUp
//
//  Created by עומר צרויה on 27/12/2020.
//

import UIKit

struct ProfileViewModel {
    
    
    private let user:User
    
    let userDetailsAttributedString: NSAttributedString
    let MyExperience: String
    let bio:String
    
    var imageUrl: URL {
        let imageUrl = URL(string: user.profileImageUrl)!
        return imageUrl
    }
    
    
    var imageCount:Int {
        return 1
    }
    
    init(user:User) {
        
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font:UIFont.systemFont(ofSize: 24,weight: .semibold)])
        attributedText.append(NSAttributedString(string: " \(user.mode)", attributes: [.font:UIFont.systemFont(ofSize: 22)]))
        userDetailsAttributedString = attributedText
        
        MyExperience = user.MyExperience
        bio = user.bio
        
        
    }
    
    
    
    
    
}
