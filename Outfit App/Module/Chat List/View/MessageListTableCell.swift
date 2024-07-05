//
//  MessageListTableCell.swift
//  Social Hunter
//
//  Created by MacAdmin on 01/09/21.
//

import UIKit

class MessageListTableCell: UITableViewCell {

    @IBOutlet weak var notificationCounter: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var userStatus: BorderImageView!
    @IBOutlet weak var userImage: BorderImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chatMessages: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
