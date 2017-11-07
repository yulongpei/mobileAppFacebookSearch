//
//  FavCell.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/26/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit

class FavCell: UITableViewCell {

    @IBOutlet weak var favName: UILabel!
    @IBOutlet weak var favPic: UIImageView!
    
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
