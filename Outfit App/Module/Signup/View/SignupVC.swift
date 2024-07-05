
import UIKit

class SignupVC: UIViewController {
    
    var isShowPassword = true
    var isConfirmShowPassword = true
    var presenter = SignupPresenter()
    
    @IBAction func didTapShowPassword(_ sender: Any) {
        isShowPassword = !isShowPassword
        
        if isShowPassword == true {
            passwordText.isSecureTextEntry = isShowPassword
        } else if isShowPassword == false {
            passwordText.isSecureTextEntry = isShowPassword
        }
    }
    
    @IBAction func didTapShowConfirmPassword(_ sender: Any) {
        isConfirmShowPassword = !isConfirmShowPassword
        
        if isConfirmShowPassword == true {
     confirmPasswordText.isSecureTextEntry = isConfirmShowPassword
        } else if isShowPassword == false {
     confirmPasswordText.isSecureTextEntry = isConfirmShowPassword
        }
    }

    @IBOutlet weak var confirmPasswordText: BorderPaddingTextField!
    @IBOutlet weak var passwordText: BorderPaddingTextField!
    @IBOutlet weak var emailText: BorderPaddingTextField!
    @IBOutlet weak var nameText: BorderPaddingTextField!
    
    
    @IBAction func didTapLogin(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSignup(_ sender: Any) {
        
//        nameText.text = "Harsh Sharma"
//        emailText.text = "harsh@test.com"
//        passwordText.text = "123456"
//        confirmPasswordText.text = "123456"
        
         if nameText.text!.count < 3 {
            self.presentAlert(withTitle: "Error!", message: "Invalid name!")
        } else if emailText.text?.isValidEmail == false {
            self.presentAlert(withTitle: "Error!", message: "Invalid Email!")
        }  else if passwordText.text!.count < 5 {
            self.presentAlert(withTitle: "Error!", message: "Password length should be more then 5 characters.")
        } else if passwordText.text! != confirmPasswordText.text {
            self.presentAlert(withTitle: "Error!", message: "Confrim password is not matching")
        } else {
            presenter.signupUser(name: nameText.text!, email: emailText.text!, password: passwordText.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }
}

extension SignupVC:SignupProtocol {
    
    func handleRegisterResponse(success: String?, failure: String?) {
        DispatchQueue.main.async {
            
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
    if failure == nil {
    self.navigationController?.popViewController(animated: true)
    appDelegate.showAlert(title: "Success!", message: success!)
            } else {
        self.presentAlert(withTitle: "Error!", message: failure!)
            }
        }
    }
}
