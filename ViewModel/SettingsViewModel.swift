//
//  SettingsViewModel.swift
//  StartUp
//
//  Created by עומר צרויה on 24/12/2020.
//

import UIKit

enum SettingsSections:Int , CaseIterable {
    
    case name
    case bio
    case employer
    case MyExperience
    case ExperinceFriend
    case mode
    
    var description: String {
        switch self {
         
        case .name: return "שם מלא "
            
        case .bio: return "ספר קצת על עצמך "
            
        case .employer: return "יכולות שאני מביא איתי (תכנות,עיצוב,שיווק)"
            
        case .MyExperience: return  "ניסיון סטארט-אפיסטי (ראשון ,הקמתי בעבר)"
            
        case .ExperinceFriend: return "יכולות רצויות בשותף הפוטנציאלי"
            
        case .mode: return "מה הסטטוס שלכם (פרילנסר,שכיר) ?"
            
    
        }
    }
}


struct SettingsViewModel {
    
    let placeholderText: String
    var value:String?
    
    private let user:User
     let section: SettingsSections
    
    init(user:User , section: SettingsSections){
        
        self.user = user
        self.section = section
        
        placeholderText = "הכנס \(section.description)"
        
        switch section {
        
        case .name: value = user.name
        case .bio: value = user.bio
        case .employer: value = user.employer
        case .MyExperience: value = user.MyExperience
        case .ExperinceFriend: value = user.ExperinceFriend
        case .mode: value = user.mode

        }
        
    }
    
    
}

