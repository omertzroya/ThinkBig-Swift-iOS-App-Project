//
//  User.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit

struct User {

    var name : String
    var employer : String
    var bio : String
    var mode :String
    var MyExperience : String
    var ExperinceFriend : String
    var email:String
    var uid: String
    var profileImageUrl: String
    
    
    init(dictionary: [String: Any]){
        self.name = dictionary["fullname"] as? String ?? ""
        self.employer = dictionary["employer"] as? String ?? ""
        self.mode = dictionary["mode"] as? String ?? ""
        self.MyExperience = dictionary["MyExperience"] as? String ?? ""
        self.ExperinceFriend = dictionary["ExperinceFriend"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrl"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""

    }

}
