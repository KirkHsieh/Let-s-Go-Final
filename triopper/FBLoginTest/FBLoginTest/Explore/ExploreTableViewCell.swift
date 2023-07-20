//
//  ExploreTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/16.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    @IBOutlet weak var exploreImage: UIImageView!
    @IBOutlet weak var exploreNameLabel: UILabel!
    @IBOutlet weak var exploreTimeLocationLabel: UILabel!
    @IBOutlet weak var relaxTagButton: UIButton!
    @IBOutlet weak var lightTripTagButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
