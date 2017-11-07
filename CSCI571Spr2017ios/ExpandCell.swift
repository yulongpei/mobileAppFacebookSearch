//
//  ExpandCell.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/25/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit

class ExpandCell: UITableViewCell {

    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumPicOne: UIImageView!
    @IBOutlet weak var albumPicTwo: UIImageView!

    @IBOutlet weak var pic1Height: NSLayoutConstraint!
    @IBOutlet weak var pic2Height: NSLayoutConstraint!

    
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.pic1Height.constant = 0.0
                self.pic2Height.constant = 0.0
                
            } else {
                self.pic1Height.constant = 160.0
                self.pic2Height.constant = 160.0
                
            }
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
