//
//  addEventTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/5.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class AddEventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventAttributeLabel: UILabel!
    @IBOutlet weak var eventContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
