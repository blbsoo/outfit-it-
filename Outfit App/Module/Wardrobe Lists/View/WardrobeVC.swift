

import UIKit
import FirebaseAuth
import iProgressHUD

class WardrobeVC: UIViewController {

    @IBOutlet weak var wardrobeTable: UITableView!
    var tableIndex:Int = 0
    
    var presenter = WardrobePresenter()
    var mediaPickerController: MediaPickerController!
    var wardrobeImage:UIImage?
    var type:String!
    
    var bottomImages:[String] = [String] ()
    var topImages:[String] = [String] ()
    var shoeImages:[String] = [String] ()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchBottomsItems(type: firebaseNodes.bottomsCloth, userID: Auth.auth().currentUser!.uid)

        
    iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        presenter.delegate = self
        self.mediaPickerController = MediaPickerController(type: .imageOnly, presentingViewController: self)
        self.mediaPickerController.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension WardrobeVC:UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
//        let label = UILabel()
//        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//
//        if section == 0 {
//        label.text = "Bottoms"
//        } else if section == 1 {
//            label.text = "Tops"
//        } else if section == 2 {
//            label.text = "Shoes"
//        }
//
//        headerView.addSubview(label)
//        return headerView
//    }
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//     return 3
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WardrobeTableCell", for: indexPath) as! WardrobeTableCell
     
       
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "Bottoms"
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "Tops"
        } else if indexPath.row == 2 {
            cell.titleLabel.text = "Shoes"
        }
        
        cell.delegate = self
        cell.itemCollection.tag = indexPath.row
        cell.setupUI(bottomImages: bottomImages, topsImages: topImages, shoeImages: shoeImages)
        
        
      //  cell.itemCollection.reloadData()
       
        return cell
    }
}

extension WardrobeVC:WardrobeListProtocol {
    func handleWardrobeListResponse(bottomList: [String]?, topsList: [String]?, shoesList: [String]?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
                self.bottomImages = bottomList!
                self.topImages = topsList!
                self.shoeImages = shoesList!
            self.wardrobeTable.reloadData()
            } else {
                print(failure!)
            }
        }
    }
 
    func handleSetWardrobeResponse(response: String?, failure: String?) {
        DispatchQueue.main.async {
            self.view.dismissProgress()
         //   DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        //   self.wardrobeTable.reloadData()
            let indexPath = IndexPath(row: self.tableIndex, section: 0)
            
            self.wardrobeTable.reloadRows(at: [indexPath],
                                          with: .none)
            
         //   }
        }
    }
    
    func setImages(type:String, imageURL:String)->[String] {
        if type == firebaseNodes.bottomsCloth {
            self.bottomImages.append(imageURL)
            return self.bottomImages
        } else  if type == firebaseNodes.tops {
            self.topImages.append(imageURL)
            return self.topImages
        }  else {
            self.shoeImages.append(imageURL)
            return self.shoeImages
        }
       
    }
    
    func handleUploadImageResponse(imageURL: String?, failure: String?) {
        DispatchQueue.main.async {
        self.view.dismissProgress()
        if failure == nil {
        self.view.showProgress()
        let image = self.setImages(type:self.type, imageURL: imageURL!)
        self.presenter.setWardrobeItems(type: self.type, userID: Auth.auth().currentUser!.uid, image: image)
            } else {
        self.presentAlert(withTitle: "Error!", message: failure!)
            }
        }
    }
}

extension WardrobeVC:WardrobeTableProtocol, MediaPickerControllerDelegate {
    
    func mediaPickerControllerDidPickImage(_ image: UIImage) {
        self.wardrobeImage = image
        self.view.showProgress()
    presenter.uploadImage(image: image, userID: Auth.auth().currentUser!.uid, type: self.type)
    }
    
    func pickImageForGallery(){
    self.mediaPickerController.show()
    }
    
    func handleImageOptions(type: String) {
        if type == firebaseNodes.bottomsCloth {
            tableIndex = 0
        } else if type == firebaseNodes.tops {
            tableIndex = 1
        } else if type == firebaseNodes.shoes {
            tableIndex = 2
        }
        
        pickImageForGallery()
        self.type = type
    }
}

extension WardrobeVC {
    
    
    
}
