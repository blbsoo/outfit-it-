//
//  ChatMessageModel.swift
//  Outfit App
//
//  Created by Krishna Sharma on 03/12/21.
//

import UIKit

struct ChatMessageModel {
    
    var senderID:String!
    var message:String!
    var timeStamp:Double!

    init(senderID:String, message:String, timeStamp:Double) {
        self.senderID = senderID
        self.message = message
        self.timeStamp = timeStamp
    }
    

}
