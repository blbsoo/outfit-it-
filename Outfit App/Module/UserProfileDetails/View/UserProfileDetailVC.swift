//
//  UserProfileDetailVC.swift
//  Outfit App
//
//  Created by Krishna Sharma on 24/11/21.
//

import UIKit
import FirebaseAuth
import SDWebImage

class UserProfileDetailVC: UIViewController {
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    var image:UIImage!
    var mediaPickerController: MediaPickerController!
    var presenter = UserProfileDetailPresenter()
    var gender = "Male"
    
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func genderSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            gender = "Female"
        } else {
            gender = "Male"
        }
    }
    
    @IBOutlet weak var textAge: BorderPaddingTextField!
    @IBOutlet weak var textName: BorderPaddingTextField!
    @IBOutlet weak var textEmail: BorderPaddingTextField!
    @IBOutlet weak var userProfileImg: BorderImageView!
    
    @IBAction func didTapProfileImage(_ sender: Any) {
        self.mediaPickerController.show()
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
        if image != nil {
            presenter.uploadImage(image: image, userID: Auth.auth().currentUser!.uid)
        }
        
        if textName.text!.count < 3 {
           self.presentAlert(withTitle: "Error!", message: "Invalid name!")
       } else if textAge.text!.count < 1 {
           self.presentAlert(withTitle: "Error!", message: "Invalid Age!")
       } else {
           self.presenter.updateProfile(name: textName.text!, age: textAge.text!, gender: gender)
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediaPickerController = MediaPickerController(type: .imageOnly, presentingViewController: self)
        self.mediaPickerController.delegate = self
        presenter.delegate = self
        presenter.fetchUserProfile(userID: Auth.auth().currentUser!.uid)
    }
}

extension UserProfileDetailVC:MediaPickerControllerDelegate, UserProfileDetailProtocol {
    
    func handleUserData(response: UserProfileDetailModel?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
                self.textName.text = response!.name
                self.textAge.text = response!.age
                self.textEmail.text = response!.email
      
    let imageURL = URL(string: response!.profileImage)
                
    self.userProfileImg.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImages"))
                
                if response!.gender == "Male" {
                    self.genderSegment.selectedSegmentIndex = 1
                } else {
                    self.genderSegment.selectedSegmentIndex = 0
                }
                    

                
            }
        }
    }
    
    func handleUploadImageResponse(imageURL: String?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
            self.presenter.updateUserProfile(imageURL: imageURL!)
            }
        }
    }
    
    func mediaPickerControllerDidPickImage(_ image: UIImage) {
        self.userProfileImg.image = image
        self.image = image
    }
}

