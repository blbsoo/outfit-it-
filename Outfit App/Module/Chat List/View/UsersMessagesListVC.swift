
import UIKit
import SDWebImage

class UsersMessagesListVC: UIViewController {
    
    @IBOutlet weak var userCollection: UICollectionView!
    @IBOutlet weak var messageTable: UITableView!
    var presenter = UserChatListPresenter()
    var usersListData = [UsersChatList]()
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        hideKeyboardWhenTappedAround()
        presenter.fetchChatListMessages()
        presenter.fetchUsersChatList()
       
        self.messageTable.estimatedRowHeight = 120
        self.messageTable.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
    }
}

extension UsersMessagesListVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MessagesListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessagesListCell", for: indexPath) as! MessagesListCell
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: 70, height: 70)
        }
}

extension UsersMessagesListVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell:MessageListTableCell = tableView.dequeueReusableCell(withIdentifier: "MessageListTableCell", for: indexPath) as! MessageListTableCell
        
        let chatList = self.usersListData[indexPath.row]
    
        let imageURL = URL(string: chatList.profilePic!)
        cell.userImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImages"))
        cell.chatMessages.text = chatList.lastMsg
        cell.userName.text = chatList.name
        cell.lblTime.text = GlobalConstant().timeStampToDate(timeStamp: chatList.timeStamp!)

        
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatList = self.usersListData[indexPath.row]
        let controller = UIStoryboardCreation.loadChatViewMessages()
        controller.receiverID = chatList.senderID
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


extension UsersMessagesListVC:chatListProtocol {
    
    func getUsersChat(usersData: UsersChatList) {
        DispatchQueue.main.async {
        if let index = self.usersListData.firstIndex(where: { ($0.senderID!) == usersData.senderID }) {
            self.usersListData[index] = usersData
        } else {
            self.usersListData.append(usersData)
        }
        self.usersListData.sort(by: { $0.timeStamp! > $1.timeStamp! })
        self.messageTable.reloadData()
        self.userCollection.reloadData()
    }
    }
    
    func retriveChatID(chatID: String) {
        DispatchQueue.main.async {
            
        }
    }
    
    
    
    
    
}
