//
//  SetPrivateTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/5.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class SetPrivateTableViewCell: UITableViewCell {

    @IBOutlet weak var privacyItemLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
