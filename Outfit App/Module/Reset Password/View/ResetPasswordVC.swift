//
//  ResetPasswordVC.swift
//  Outfit App
//
//  Created by Krishna Sharma on 24/11/21.
//

import UIKit


class ResetPasswordVC: UIViewController {

    @IBOutlet weak var resetText: BorderPaddingTextField!
    var presenter = ResetPasswordPresenter()
    
    @IBAction func didTapResetPassword(_ sender: Any) {
        if resetText.text?.isValidEmail == false {
        self.presentAlert(withTitle: "Error!", message: "Invalid Email!")
        } else {
            presenter.resetPassword(email: resetText.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self

        // Do any additional setup after loading the view.
    }
}


extension ResetPasswordVC:ResetPasswordProtocol {
    
    func handleResponse(success: String?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showAlert(title: "Success!", message: success!)
        self.navigationController?.popViewController(animated: true)
            } else {
        self.presentAlert(withTitle: "Error!", message: failure!)
            }
        }
    }
}
