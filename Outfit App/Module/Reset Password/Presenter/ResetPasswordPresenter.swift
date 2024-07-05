

import Foundation
import Firebase
import FirebaseAuth

protocol ResetPasswordProtocol {
    
    func handleResponse(success:String?, failure:String?)
}

class ResetPasswordPresenter {
    
    var delegate:ResetPasswordProtocol!
    
    func resetPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                self.delegate.handleResponse(success: "Reset Password link sent to email!", failure: nil)
            } else {
                print(error?.localizedDescription)
                self.delegate.handleResponse(success: nil, failure: error?.localizedDescription)
            }
        }
        }
    
}
