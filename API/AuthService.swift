//
//  AuthService.swift
//  StartUp
//
//  Created by עומר צרויה on 15/12/2020.
//

import UIKit
import Firebase
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let profileImage: UIImage
}

struct AuthService {
    
    
    static func LogUserIn (withEmail email : String , password: String , completion:AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    

    
     static func registerUser( withCredentials credentials: AuthCredentials , completion: @escaping ((Error?) -> Void)) {
      Service.uploadImage(image: credentials.profileImage) { imageUrl in
          Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
              if let error = error {
                  print("DEBUG: ERORR signing user   \(error.localizedDescription)")
                  return
              }
              
              guard let uid = result?.user.uid else {return}
              let data = ["email": credentials.email , "fullname":credentials.fullName , "imageUrl":imageUrl,"uid": uid]
              Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
          }
          
      }
      
    } //END func
    
}
    


    

