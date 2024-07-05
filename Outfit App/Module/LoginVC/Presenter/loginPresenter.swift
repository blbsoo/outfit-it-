
import UIKit
import FirebaseAuth


protocol loginProtocol {
    func userLoggedIn(userID:String?, failure:String?)
}

class LoginPresenter:NSObject {
   var delegate:loginProtocol?
    
    func userAuthentication(email:String, password:String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            print(result)
            if let error = error {
                if error.localizedDescription.contains("There is no user") {
                self.delegate?.userLoggedIn(userID: nil, failure: "")
                } else {
                    self.delegate?.userLoggedIn(userID: nil, failure: error.localizedDescription)
                }
                print(error.localizedDescription)
            } else {
                self.delegate?.userLoggedIn(userID: Auth.auth().currentUser!.uid, failure: nil)
            }
        }
    }
}




