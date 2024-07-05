//
//  SenderMessageCell.swift
//  Outfit App
//
//  Created by Krishna Sharma on 03/12/21.
//

import UIKit

class SenderMessageCell: UITableViewCell {
    @IBOutlet weak var userImg: BorderImageView!
    @IBOutlet weak var timeValueLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
