//
//  AunthenticationBiewModel.swift
//  StartUp
//
//  Created by עומר צרויה on 13/12/2020.
//

import Foundation

protocol AunthenticationViewModel {
    var formIsVaild: Bool { get }
}


struct LoginViewModel{
    
    var email: String?
    var password: String?
    
    var formIsvalid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    
    
}

struct RegistrationViewModel: AunthenticationViewModel {
    
    var email: String?
    var password: String?
    var fullName: String?
    
    var formIsVaild: Bool {
        return email?.isEmpty == false && password?.isEmpty == false &&   fullName?.isEmpty == false
    }
    
    
}
