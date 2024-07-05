//
//  UsersListModel.swift
//  Outfit App
//
//  Created by Krishna Sharma on 03/12/21.
//

import Foundation

struct UsersListModel {
   
    var name:String!
    var userID:String!
    var userImage:String!
    
    init(name:String, userID:String, userImage:String) {
        self.name = name
        self.userID = userID
        self.userImage = userImage
    }
    
}
