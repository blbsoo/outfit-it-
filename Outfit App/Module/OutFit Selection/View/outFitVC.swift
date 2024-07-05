
import UIKit

class outFitVC: UIViewController {
    
    var mediaPickerController: MediaPickerController!
    var index = 0

    @IBOutlet weak var textDate: UITextField!
    @IBOutlet weak var textWeather: UITextField!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    
    @IBAction func didTapImage1(_ sender: Any) {
        index = 0
        self.mediaPickerController.show()
    }
    
    @IBAction func didTapImage2(_ sender: Any) {
        index = 1
        self.mediaPickerController.show()
    }
    
    @IBAction func didTapImage3(_ sender: Any) {
        index = 2
        self.mediaPickerController.show()
    }
    
    @IBAction func didTapWeather(_ sender: Any) {
        let alert = UIAlertController(title: "Weather", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Spring", style: .default , handler:{ (UIAlertAction)in
                self.textWeather.text = "Spring"
            }))
        
        alert.addAction(UIAlertAction(title: "Autumn", style: .default , handler:{ (UIAlertAction)in
            self.textWeather.text = "Autumn"
        }))
            
            alert.addAction(UIAlertAction(title: "Winter", style: .default , handler:{ (UIAlertAction)in
                self.textWeather.text = "Winter"
            }))

            alert.addAction(UIAlertAction(title: "Summer", style: .default , handler:{ (UIAlertAction)in
                self.textWeather.text = "Summer"
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.mediaPickerController = MediaPickerController(type: .imageOnly, presentingViewController: self)
        self.mediaPickerController.delegate = self
        self.textDate.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
           if let datePicker = self.textDate.inputView as? UIDatePicker { // 2-1
               let dateformatter = DateFormatter() // 2-2
               dateformatter.dateStyle = .medium // 2-3
               self.textDate.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.textDate.resignFirstResponder() // 2-5
       }
}

extension outFitVC:MediaPickerControllerDelegate {
    
    func mediaPickerControllerDidPickImage(_ image: UIImage) {
        if index == 0 {
            self.image1.image = image
        } else if index == 1 {
            self.image2.image = image
        } else if index == 2 {
            self.image3.image = image
        }
    }
}
