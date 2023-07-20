//
//  GoTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/14.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class GoTableViewCell: UITableViewCell {

    @IBOutlet weak var goImage: UIImageView!
    @IBOutlet weak var goNameLabel: UILabel!
    @IBOutlet weak var goTimeLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
