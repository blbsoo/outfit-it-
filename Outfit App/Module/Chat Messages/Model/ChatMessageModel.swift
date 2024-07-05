
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
