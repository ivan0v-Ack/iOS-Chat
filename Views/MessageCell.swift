//
//  MessageCell.swift
//  Chat
//
//  Created by Ivan Ivanov on 2/12/21.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!

    
    @IBOutlet weak var messageBuble: UIView!
    @IBOutlet weak var labelCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
