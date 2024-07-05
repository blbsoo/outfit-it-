

import UIKit
import Firebase
import FirebaseAuth


protocol SignupProtocol {
    func handleRegisterResponse(success:String?, failure:String?)
}


class SignupPresenter: NSObject {
    
    var delegate:SignupProtocol?
    
    func signupUser(name:String, email:String, password:String){
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] (user, error) in
            if error == nil {
                self.userDataSetup(name: name, userID: (user?.user.uid)!, email: email)
                self.delegate?.handleRegisterResponse(success: "User Signed UP Successfully", failure: nil)
            } else {
                self.delegate?.handleRegisterResponse(success: nil, failure: error?.localizedDescription)
            }
        }
    }
    
    
    private func userDataSetup(name:String, userID:String, email:String){
        
        let ref = DatabaseConnectionManager().databaseRef()
        
        ref.child(firebaseNodes.users).child(userID).setValue(["userID": userID,"name":name, "email":email, "userType":"iOS", "profileImage":"", "age":"", "gender":""]) { (error, dataRef) in
            
//            if error == nil {
//            } else {
//            }
        }
    }


}


