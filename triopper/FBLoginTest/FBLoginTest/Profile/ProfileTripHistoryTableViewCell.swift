//
//  ProfileTripHistoryTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/6/1.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class ProfileTripHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var profileTripHistoryImage: UIImageView!
    @IBOutlet weak var profileTripHistoryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
