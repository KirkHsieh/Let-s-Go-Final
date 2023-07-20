//
//  AdventureTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/4.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class AdventureTableViewCell: UITableViewCell {

    @IBOutlet weak var adventureImage: UIImageView!
    @IBOutlet weak var adventureNameLabel: UILabel!
    @IBOutlet weak var adventureTimeLocationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
