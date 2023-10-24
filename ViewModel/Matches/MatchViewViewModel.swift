//
//  MatchViewViewModel.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit

struct MatchViewViewModel {
    
    private let currentUser: User
    let matchedUser: User
    
    let matchLabelText: String
    
    var currentUserImageURL: URL?
    var matchedUserImageURL: URL?
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
       
        matchLabelText = "אתה ו\(matchedUser.name)יצרתם חיבור עסקי \n זה הזמן לחלום ביחד ! "
        
    
        currentUserImageURL = URL(string:currentUser.profileImageUrl )
        matchedUserImageURL = URL(string:matchedUser.profileImageUrl)
        
    }
}
