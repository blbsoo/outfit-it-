
import UIKit
import SDWebImage

class UsersListCollection: UICollectionViewCell {
    
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userStatus: radiusLabel!
    
    func setupUI(age:String, profileImage:String){
        print(age)
        print(profileImage)
        self.ageLbl.text = age
        let imageURL = URL(string: profileImage)
        userImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImages"))

    }
}
