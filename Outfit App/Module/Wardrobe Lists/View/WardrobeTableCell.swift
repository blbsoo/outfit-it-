
import UIKit
import SDWebImage

import Kingfisher

protocol WardrobeTableProtocol {
func handleImageOptions(type:String)
}

class WardrobeTableCell: UITableViewCell {
    var tagValue = 0
    @IBOutlet weak var titleLabel: UILabel!
    var bottomImages:[String] = [String]()
    var shoeImages:[String] = [String]()
    var topsImages:[String] = [String]()

    var delegate:WardrobeTableProtocol!
    @IBOutlet weak var itemCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemCollection.delegate = self
        self.itemCollection.dataSource = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(bottomImages:[String], topsImages:[String], shoeImages:[String]){
        self.bottomImages = bottomImages
        self.topsImages = topsImages
        self.shoeImages = shoeImages
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.itemCollection.reloadData()
           //     }
//        itemCollection.reloadData()
        
    }

}

extension WardrobeTableCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == tagValue {
            return bottomImages.count + 1
        } else if collectionView.tag == tagValue + 1 {
            return topsImages.count + 1
        } else if collectionView.tag == tagValue + 2 {
            return shoeImages.count + 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:WardrobeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WardrobeCollectionCell", for: indexPath) as! WardrobeCollectionCell
        
        if collectionView.tag == tagValue {

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if self.bottomImages.count == indexPath.row {
                cell.imageBtn.isHidden = false
            } else {
                let imageURL = URL(string: self.bottomImages[indexPath.row])
                cell.imageBtn.isHidden = true
                cell.wardrobeImageView.kf.setImage(with: imageURL)
                
           //   cell.wardrobeImageView.sd_setImage(with:imageURL, placeholderImage: UIImage(named: ""))
             }
            }
        } else if collectionView.tag == tagValue + 1 {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if self.topsImages.count == indexPath.row {
                cell.imageBtn.isHidden = false
            } else {
                let imageURL = URL(string: self.topsImages[indexPath.row])
                cell.imageBtn.isHidden = true
                cell.wardrobeImageView.kf.setImage(with: imageURL)
            //    cell.wardrobeImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: ""))
            }
            }
        } else if collectionView.tag == tagValue + 2 {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if self.shoeImages.count == indexPath.row {
            cell.imageBtn.isHidden = false
            } else {
                let imageURL = URL(string: self.shoeImages[indexPath.row])
            cell.imageBtn.isHidden = true
         //       cell.wardrobeImageView.kf.setImage(with: imageURL)
            cell.wardrobeImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: ""))
            }
        }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: 120, height: 140)
       }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == tagValue {
        if bottomImages.count == indexPath.row {
    delegate.handleImageOptions(type: firebaseNodes.bottomsCloth)
            }
        } else if collectionView.tag == tagValue + 1 {
            if topsImages.count == indexPath.row {
    delegate.handleImageOptions(type: firebaseNodes.tops)
            }
        } else if collectionView.tag == tagValue + 2 {
            if shoeImages.count == indexPath.row {
    delegate.handleImageOptions(type: firebaseNodes.shoes)
            }
        }
    }
    
}
