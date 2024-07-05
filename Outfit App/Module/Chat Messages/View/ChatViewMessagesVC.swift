

import UIKit
import FirebaseAuth

class ChatViewMessagesVC: UIViewController {
    
    var chatID:String = ""
    var receiverID:String!
    var presenter = ChatViewMessagePresenter()
    var chatMessagesData = [ChatMessageModel]()
    
    
    @IBAction func didTapBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        print(textMessage.text!)
        if chatID == "" {
            print(chatID)
        } else if textMessage.text!.count != 0 {
            presenter.saveMessage(chatID: chatID, message: textMessage.text!, senderID: Auth.auth().currentUser!.uid, type: "Text", receiverID:receiverID)
        }
    }
    
    @IBOutlet weak var textMessage: BorderPaddingTextField!
    
    
    
    
    @IBOutlet weak var chatTable: UITableView!
    
    func setupUI(){
 
    self.chatTable.register(SenderMessageCell.nib, forCellReuseIdentifier: "SenderMessageCell")
    self.chatTable.register(ReceiverMessageCell.nib, forCellReuseIdentifier: "ReceiverMessageCell")
            self.chatTable.tableFooterView = UIView()
            self.chatTable.separatorStyle = .none
        
        self.chatTable.estimatedRowHeight = 120
        self.chatTable.rowHeight = UITableView.automaticDimension
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        presenter.delegate = self
        presenter.getMessages(senderID: receiverID)
        // Do any additional setup after loading the view.
    }
}


extension ChatViewMessagesVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatMessagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatData = self.chatMessagesData[indexPath.row]
        if chatData.senderID != Auth.auth().currentUser!.uid {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessageCell", for: indexPath) as! SenderMessageCell
            cell.messageLbl.text = chatData.message
            cell.timeValueLbl.text = GlobalConstant().timeStampToDate(timeStamp: chatData.timeStamp)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverMessageCell", for: indexPath) as! ReceiverMessageCell
            cell.messageLabel.text = chatData.message
            cell.messageTime.text =  GlobalConstant().timeStampToDate(timeStamp: chatData.timeStamp)  
                return cell
        }
    }
}

extension ChatViewMessagesVC:ChatViewMessageProtocol {
    func handleChatMessages(response: ChatMessageModel?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
                self.chatMessagesData.append(response!)
                self.chatTable.reloadData()
            } else {
                
            }
        }
    }

    
    func handleChatID(chatID: String?, failure: String?) {
        DispatchQueue.main.async {
            if failure == nil {
                self.chatID = chatID!
                self.presenter.getChatMessage(chatID: chatID!)
            }
        }
    }
    
    
    
}
