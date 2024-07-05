
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol ChatViewMessageProtocol {
    
    func handleChatID(chatID:String?, failure:String?)
    func handleChatMessages(response:ChatMessageModel?, failure:String?)
}

class ChatViewMessagePresenter: NSObject {
    
    var delegate:ChatViewMessageProtocol!
    
    func getMessages(senderID:String){
        
        let chatID = GlobalConstant().chatIDCreation(userID: Auth.auth().currentUser!.uid, senderID: senderID)
        
        let ref = DatabaseConnectionManager().databaseRef()
        ref.child(firebaseNodes.usersMessages).child(chatID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String:Any] {
        self.delegate.handleChatID(chatID: chatID, failure: nil)
                print(value)
                // node is available share chatID for the conversation
            } else {
                let chatID = GlobalConstant().chatIDCreation(userID:senderID, senderID: Auth.auth().currentUser!.uid)
                
                ref.child(firebaseNodes.usersMessages).child(chatID).observeSingleEvent(of: .value) {
                    (snapshot) in
                    if let value = snapshot.value as? [String:Any] {
                        print(value)
        self.delegate.handleChatID(chatID: chatID, failure: nil)
                        // node is available share chatID for the conversation
                    } else {
            self.delegate.handleChatID(chatID: chatID, failure: nil)
                    }
                }
            }
        }
    }
    
    func createChatList(receiverID:String, userID:String, message:String) {
        
        let ref = DatabaseConnectionManager().databaseRef()
        ref.child(firebaseNodes.chatList).child(userID).child(receiverID).setValue(["lastMsg": message,
                                          "timeStamp":ServerValue.timestamp(), "type":"text"]) { (error, dataRef) in
                                        
            if error == nil {
                
                
            }
            print(error?.localizedDescription)
                                                                                        //print(error!)
                                                                                        //  print(dataRef)
        }
        
    }
    
    func saveMessage(chatID:String, message:String, senderID:String, type:String,receiverID:String) {
        
        let ref = DatabaseConnectionManager().databaseRef()
        let timeStamp = ServerValue.timestamp()
        ref.child(firebaseNodes.usersMessages).child(chatID).childByAutoId().setValue(["message": message,
                                                                                       "senderID":senderID, "timeStamp":timeStamp, "type":"text"]) { (error, dataRef) in
                                        
        if error == nil {
        self.createChatList(receiverID: receiverID, userID: senderID, message: message)
        self.createChatList(receiverID: senderID, userID: receiverID, message: message)
                
                
            }
            print(error?.localizedDescription)
                                                                                        //print(error!)
                                                                                        //  print(dataRef)
        }
    }
    
    func getChatMessage(chatID:String){
            let ref = DatabaseConnectionManager().databaseRef()
            ref.child(firebaseNodes.usersMessages).child(chatID).observe(.childAdded, with: { (snapshot) in
                var chatMessages = [ChatMessageModel]()
                
                if let value = snapshot.value as? [String:Any] {
                    print(value)
                    
                    var timeStamp:Double = 0.0
                    var message:String = ""
                    var senderID:String = ""
                    var type:String = ""
                    
        if let timeStamps = value["timeStamp"] as? Double {
        
            timeStamp = timeStamps
            
        }
                    if let messages = value["message"] as? String {
                    
                        message = messages
                        
                    }
                    
                    if let senderIDs = value["senderID"] as? String {
                    
                        senderID = senderIDs
                        
                    }
                    
                    if let types = value["type"] as? String {
                    
                        type = types
                        
                    }
                    
                    print(message)
  let temp = ChatMessageModel(senderID: senderID, message: message, timeStamp: timeStamp)
                    
chatMessages.append(temp)
self.delegate.handleChatMessages(response: temp, failure: nil)
                } else {
self.delegate.handleChatMessages(response: nil, failure: "Error")
                }
            }) { (error) in
                print(error.localizedDescription)
                self.delegate.handleChatMessages(response: nil, failure: error.localizedDescription)
            }
        }
    

}
