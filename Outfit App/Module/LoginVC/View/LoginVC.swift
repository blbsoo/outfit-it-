
import UIKit

class LoginVC: UIViewController {
    
    var isShowPassword = true

    @IBAction func didTapShowPassword(_ sender: Any) {
        isShowPassword = !isShowPassword
        if isShowPassword == true {
            passwordText.isSecureTextEntry = isShowPassword
        } else if isShowPassword == false {
            passwordText.isSecureTextEntry = isShowPassword
        }
    }
    
    var presenter = LoginPresenter()
    @IBOutlet weak var passwordText: BorderPaddingTextField!
    @IBOutlet weak var emailText: BorderPaddingTextField!
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        
        
    if emailText.text?.isValidEmail == false {
    self.presentAlert(withTitle: "Error!", message: "Invalid Email!")
        } else if passwordText.text!.count < 5 {
          self.presentAlert(withTitle: "Error!", message: "Password length should be more then 5 characters.")
        } else {
            presenter.userAuthentication(email: emailText.text!, password: passwordText.text!)
        }
    }
    
    override func viewDidLoad() {
        
        self.emailText.text = "harsh@test.com"
        self.passwordText.text = "123456"
        super.viewDidLoad()
        presenter.delegate = self
    }
}

extension LoginVC:loginProtocol {
    func userLoggedIn(userID: String?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.navigationRootViewController(storyBoardID: storyboardIdentifier.home, viewControllerID: viewControllerIdentifier.tabBarVC)

            } else {
    self.presentAlert(withTitle: "outFit", message: failure!)
            }
            
        }
    }
}
