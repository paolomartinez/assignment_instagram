//
//  PostCell.swift
//  Instagram
//
//  Created by PJ Martinez on 2/26/18.
//  Copyright © 2018 Paolo Martinez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var postUsernameLabel: UILabel!
    
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
