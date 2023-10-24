//
//  Service.swift
//  StartUp
//
//  Created by עומר צרויה on 15/12/2020.
//

import UIKit
import Firebase

struct Service {

    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
       
        
        fetchSwipes { swipedUserIDs in
            COLLECTION_USERS.getDocuments { (snapshot, error) in
                guard let snapshot = snapshot else {return}
                snapshot.documents.forEach({ document in
                    let dictionary = document.data()
                    let user = User(dictionary: dictionary)
                    
                    guard user.uid != Auth.auth().currentUser?.uid else {return}
                    guard swipedUserIDs[user.uid] == nil else {return}
                    users.append(user)
                    
                })
                completion(users)
            }

        }
    
    }
    

    private static func fetchSwipes(completion: @escaping([String: Bool]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_SWIPES.document(uid).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() as? [String: Bool] else {
                completion([String: Bool]())
                return
            }
            
            completion(data)
        }
    }
    
    
    static func saveUserDate(user:User , completion:@escaping(Error?) -> Void){
        
        
        let data = ["uid":user.uid , "fullname":user.name , "bio":user.bio , "ExperinceFriend":user.ExperinceFriend, "MyExperience":user.MyExperience , "mode":user.mode , "imageUrl":user.profileImageUrl , "employer":user.employer,"email":user.email ]
        COLLECTION_USERS.document(user.uid).setData(data, completion: completion)
        
        
        
        
    }
    
    static func saveSwipe(forUser user: User , isLike:Bool, completion: ((Error?) -> Void)?){
        guard let uid = Auth.auth().currentUser?.uid else {return}
       // let shouldLike = isLike ? 1 : 0
        
        COLLECTION_SWIPES.document(uid).getDocument { (snapshot, error) in
            let data = [user.uid: isLike]
            
            if snapshot?.exists == true {
                COLLECTION_SWIPES.document(uid).updateData(data, completion: completion)
                
                
            }else{
                COLLECTION_SWIPES.document(uid).setData(data , completion: completion)
            }
            
            
        }
        
    }
    
    
    static func checkIfMatchExists(forUser user:User , completion: @escaping(Bool) -> Void){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_SWIPES.document(user.uid).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else {return}
           guard let didMatch = data[uid] as? Bool else {return}
            completion(didMatch)
        }
        
        
    }
    
    static func fetchMatches(completion: @escaping([Match]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
//        var matches = [Match]()
        
        COLLECTION_MATCHES_MESSAGES.document(uid).collection("matches").getDocuments { (snapshot, error) in
            guard let data = snapshot else { return }
            
            let matches = data.documents.map({ Match(dictionary: $0.data()) })
            completion(matches)
            
            
            // long way using for loop
//            data.documents.forEach { document in
//                let match = Match(dictionary: document.data())
//                matches.append(match)
//            }
//            completion(matches)
        }
    }
    
    static func uploadMatch(currentUser: User, matchedUser: User) {
         let profileImageUrl = matchedUser.profileImageUrl
        let currentUserProfileImageUrl = currentUser.profileImageUrl  
        
        let matchedUserData = ["uid": matchedUser.uid,
                               "name": matchedUser.name,
                               "profileImageUrl": profileImageUrl]
        
        COLLECTION_MATCHES_MESSAGES.document(currentUser.uid).collection("matches").document(matchedUser.uid).setData(matchedUserData)
        
        let currentUserData = ["uid": currentUser.uid,
                               "name": currentUser.name,
                               "profileImageUrl": currentUserProfileImageUrl]
        
        COLLECTION_MATCHES_MESSAGES.document(matchedUser.uid).collection("matches").document(currentUser.uid).setData(currentUserData)
    }
    
    
    
    static func uploadImage(image: UIImage , completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        
        ref.putData(imageData,metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: ERORR uploading image \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
            
        }
        
    }
    
}
