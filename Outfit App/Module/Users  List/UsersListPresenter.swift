//
//  UsersListPresenter.swift
//  Outfit App
//
//  Created by Krishna Sharma on 03/12/21.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol usersListProtocol {
 
    func handleUsersListResponse(response:[UserProfileDetailModel]?, failure:String?)
    
}

class UsersListPresenter: NSObject {
    
    var delegate:usersListProtocol!
    
    func getUsers(type:String) {
        let ref = DatabaseConnectionManager().databaseRef()
        var userLists = [UserProfileDetailModel]()
      //  let refQuery:DatabaseQuery = ref.child(firebaseNodes.users)

        ref.child(firebaseNodes.users).observeSingleEvent(of: .value) { (snapshot) in
               
               if let value = snapshot.value as? [String:Any] {
                   print(value)
                   
            for userItem in value {
                print(userItem)
            if let items = userItem.value as? [String:Any] {
                print(items)
                let name = items["name"] as? String
                let age = items["age"] as? String
                let email = items["email"] as? String
                let gender = items["gender"] as? String
                let userProfile = items["profileImage"] as? String
                let userID = items["userID"] as? String
                
        let temp = UserProfileDetailModel(name: name ?? "", gender: gender ?? "", profileImage: userProfile ?? "", age: age ?? "", email: email ?? "", userID: userID ?? "")
                
            if userID != Auth.auth().currentUser!.uid {
                    userLists.append(temp)
            }
             }
                   }
    self.delegate.handleUsersListResponse(response: userLists, failure: nil)
               } else {
    self.delegate.handleUsersListResponse(response: nil, failure: "Something went wrong")
               }
           }
       }

}
