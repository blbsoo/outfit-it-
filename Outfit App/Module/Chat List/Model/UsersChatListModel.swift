

import UIKit
import Firebase

struct UsersChatList {
    
  //  var name:String?
    var senderID:String?
    var lastMsg:String?
    var timeStamp:Double?
    var unReadMsgCount:Int?
    var profilePic:String?
    var name:String?
    
    init(userData:[String:Any], senderID:String) {
      //  name = userData["name"] as? String ?? ""
        self.senderID = senderID
        lastMsg = userData["lastMsg"] as? String ?? ""
        timeStamp = userData["timeStamp"] as? Double ?? 0
     //   unReadMsgCount = userData["unReadMsgCount"] as? Int
        self.profilePic = userData["profilePic"] as? String ?? ""
    }
}

