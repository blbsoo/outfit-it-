

import UIKit
import Firebase
import FirebaseAuth

protocol UserProfileDetailProtocol {
  
func handleUploadImageResponse(imageURL: String?, failure: String?)
    func handleUserData(response:UserProfileDetailModel?, failure:String?)
    
}

class UserProfileDetailPresenter: NSObject {
    
    var delegate:UserProfileDetailProtocol!
    
    func fetchUserProfile(userID:String) {
        
        let ref = DatabaseConnectionManager().databaseRef()
        ref.child(firebaseNodes.users).child(userID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String:Any] {
              
                let name = value["name"] as? String
                let age = value["age"] as? String
                let email = value["email"] as? String
                let gender = value["gender"] as? String
                let userProfile = value["profileImage"] as? String
                let userID = value["userID"] as? String
                
        let temp = UserProfileDetailModel(name: name ?? "", gender: gender ?? "", profileImage: userProfile ?? "", age: age ?? "", email: email ?? "", userID: userID ?? "")
        self.delegate.handleUserData(response: temp, failure: nil)
            } else {
        self.delegate.handleUserData(response: nil, failure: "Error")
   
            }
        }
    }
    
    func updateUserProfile(imageURL:String) {
        let ref = DatabaseConnectionManager().databaseRef()
        ref.root.child(firebaseNodes.users).child(Auth.auth().currentUser!.uid).updateChildValues(["profileImage":imageURL]) { (error, snapshot) in
            if error == nil {
      
            } else {
       
            }
        }
    }
    
    func updateProfile(name:String, age:String, gender:String) {
        let ref = DatabaseConnectionManager().databaseRef()
        ref.root.child(firebaseNodes.users).child(Auth.auth().currentUser!.uid).updateChildValues(["profileImage":"", "name":name, "age":age, "gender":gender]) { (error, snapshot) in
            if error == nil {
      
            } else {
       
            }
        }
    }
    
    func uploadImage(image:UIImage, userID:String){
        let storage = Storage.storage()
          let imageName = userID + ".png"
        let imageRef = storage.reference().child("userImages").child(imageName)
        
        if let uploadData = image.jpegData(compressionQuality: 0.2) {
            imageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error == nil {
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                      }
        imageRef.downloadURL { (url, error) in
        print(url?.absoluteString)
                        if error == nil {
    self.delegate?.handleUploadImageResponse(imageURL: url?.absoluteString, failure: nil)
                        } else {
    self.delegate?.handleUploadImageResponse(imageURL: nil, failure: error?.localizedDescription)
                        }
                    }
                } else {
    self.delegate?.handleUploadImageResponse(imageURL: nil, failure: error?.localizedDescription)
                }
            }
        }
        
    }

}
