//
//  ProfileTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/3/31.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class ProfilePersonalTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePersonalAttributeImage: UIImageView!
    @IBOutlet weak var profilePersonalContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
