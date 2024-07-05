
import UIKit

class UsersListVC: UIViewController {
    
    @IBOutlet weak var usersListCollection: UICollectionView!
    
    var presenter = UsersListPresenter()
    var usersListsData = [UserProfileDetailModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.getUsers(type: "All")
        // Do any additional setup after loading the view.
    }
}


extension UsersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userID = usersListsData[indexPath.row]
        let viewC = UIStoryboardCreation.loadChatViewMessages()
        viewC.receiverID = userID.userID
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersListsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UsersListCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersListCollection", for: indexPath) as! UsersListCollection
        
        let users = usersListsData[indexPath.row]
        cell.setupUI(age: users.age, profileImage: users.profileImage)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (collectionView.frame.size.width/3), height: 130)
        }
    
}


extension UsersListVC:usersListProtocol {
    
func handleUsersListResponse(response: [UserProfileDetailModel]?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
                
    self.usersListsData = response ?? [UserProfileDetailModel]()
    self.usersListCollection.reloadData()
            }
            
            
        }
    }
    
    
    
}
