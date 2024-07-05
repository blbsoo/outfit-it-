//
//  ReceiverMessageCell.swift
//  Outfit App
//
//  Created by Krishna Sharma on 03/12/21.
//

import UIKit

class ReceiverMessageCell: UITableViewCell {
    @IBOutlet weak var userImage: BorderImageView!
    
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
