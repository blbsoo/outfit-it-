//
//  UserChatListPresenter.swift
//  InstantChat
//
//  Created by MacAdmin on 11/12/19.
//  Copyright © 2019 MacAdmin. All rights reserved.
//

import UIKit
import Firebase

protocol chatListProtocol {
    func getUsersChat(usersData:UsersChatList)
    func retriveChatID(chatID:String)
}

class UserChatListPresenter {
    var delegate:chatListProtocol?
    var chatListData:UsersChatList!
    
    func fetchUsersChatList() {
        let ref = DatabaseConnectionManager().databaseRef()
        let userID = Auth.auth().currentUser?.uid

        ref.child(firebaseNodes.chatList).child(userID!).observe(.childAdded, with: { (snapshot) in
            if let value = snapshot.value as? [String:Any] {
                let senderID = snapshot.key
//                print("data is \(value ["lastMsg"] as! String)")
//                print("data is \(value ["unReadMsgCount"] as! Int)")
//                print("data is \(value ["timeStamp"] as! Double)")
//                print("data is \(value ["senderID"] as! String)")

                self.chatListData = UsersChatList(userData: value, senderID: senderID)
            
                 let ref2 = DatabaseConnectionManager().databaseRef()
                 
                    ref2.child(firebaseNodes.users).child(senderID).observeSingleEvent(of: .value) { (snapshot) in
                        
    if let value = snapshot.value as? [String:Any]{
        
    self.chatListData.name = value["name"] as? String
    self.chatListData.profilePic = value["profileImage"] as? String
    self.delegate?.getUsersChat(usersData: self.chatListData)
                        }
                    }
                }
    
        }) { (error) in
            print(error.localizedDescription)
        }
      }

    func fetchUserProfile(){
     let ref = DatabaseConnectionManager().databaseRef()
     
        ref.child(firebaseNodes.users).child(self.chatListData.senderID!).observeSingleEvent(of: .value) { (snapshot) in
            
            if let value = snapshot.value as? [String:Any] {
                
                print(value["name"] as! String)
                print(value["profilePic"] as? String)
                
//                self.chatListData.name = value["username"] as? String
               // self.chatListData.profilePic = value["profilePic"] as? String
            }
        }
    }
    
 func fetchChatListMessages() {
   let ref = DatabaseConnectionManager().databaseRef()
   let userID = Auth.auth().currentUser?.uid

     ref.child(firebaseNodes.chatList).child(userID!).observe(.childChanged, with: { (snapshot) in
         let senderID = snapshot.key
       if let value = snapshot.value as? [String:Any] {
           
var tempChatList = UsersChatList(userData: value, senderID: senderID)
           
           let ref2 = DatabaseConnectionManager().databaseRef()
           
              ref2.child(firebaseNodes.users).child(senderID).observeSingleEvent(of: .value) { (snapshot) in
                  
      if let value = snapshot.value as? [String:Any] {
      tempChatList.name = value["name"] as? String
      tempChatList.profilePic = value["profileImage"] as? String
      self.delegate?.getUsersChat(usersData: tempChatList)
                  }
              }
               }
   }) { (error) in
       print(error.localizedDescription)
   }
 }
    
    func getChatID(senderID:String){
//
//        let chatID = commonMethods().chatIDCreation(userID: Auth.auth().currentUser!.uid, senderID: senderID)
//
//        let ref = DatabaseConnectionManager().databaseRef()
//        ref.child(firebaseNodes.usersMessages).child(chatID).observeSingleEvent(of: .value) { (snapshot) in
//            if let value = snapshot.value as? [String:Any] {
//                self.delegate?.retriveChatID(chatID: chatID)
//                print(value)
//                // node is available share chatID for the conversation
//            } else {
//                let chatID = commonMethods().chatIDCreation(userID:senderID, senderID: Auth.auth().currentUser!.uid)
//
//                ref.child(firebaseNodes.usersMessages).child(chatID).observeSingleEvent(of: .value) {
//                    (snapshot) in
//                    if let value = snapshot.value as? [String:Any] {
//                        print(value)
//                        self.delegate?.retriveChatID(chatID: chatID)
//                    } else {
//                        self.delegate?.retriveChatID(chatID: chatID)
//                    }
//                }
//            }
//        }
    }
}

//Single Responsiblity Principle
//Each an every class you create/change should have only one responsibility
//Lets see an example explaining it, I have to develop a messenger app screen to get the list of past conversations. So I have a ConversationDataController which gets me the array of previous Conversation objects.
//
//
//
//
//How many responsiblity does this class have ?
//Gets the conversation data form the API
//Parse and create conversation objects from API response
//Saves the conversation array to CoreData Database
//If we have to implement NSURLSession for getting Json Data from API, and JSONSerialization to parse and Core Data Stack for saving to Database, this class becomes huge monster class.
//we can solve this problem moving the each responsiblity down to different classes
//I have created seperate classes for each responsiblity which ConversationDataController was handling, after segregating this is how our classes looks
//
//
//This principle helps you to keep your classes as clean as possible, and we have a advantage of testing each and every API separately, with previous implementation we would not be able to test `requestDataFromAPI()`, `parseAndCreateConversationsFrom(data:Any)`and `saveToDatabase(conversations:[Any])` because they were private funtions inside ConversationDataController.
