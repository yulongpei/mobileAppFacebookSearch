//
//  searchCell.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/22/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit

class searchCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var favButton: UIImageView!
    
    var profileID:String = ""
    var profileURL:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
