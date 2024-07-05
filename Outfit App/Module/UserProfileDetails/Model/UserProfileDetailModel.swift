

import UIKit

struct UserProfileDetailModel {

    var userID:String!
    var name:String!
    var gender:String!
    var profileImage:String!
    var age:String!
    var email:String!
    
    init(name:String, gender:String, profileImage:String, age:String, email:String, userID:String) {
        self.name = name
        self.gender = gender
        self.profileImage = profileImage
        self.age = age
        self.email = email
        self.userID = userID
    }
    
}
