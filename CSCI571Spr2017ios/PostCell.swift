//
//  PostCell.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/25/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postPic: UIImageView!
    
    @IBOutlet weak var postMessage: UILabel!
    
    @IBOutlet weak var postTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
