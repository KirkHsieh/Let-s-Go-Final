//
//  FansTableViewCell.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/1.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class FansTableViewCell: UITableViewCell {

    @IBOutlet weak var fansPhotoImage: UIImageView!
    @IBOutlet weak var fansNameLabel: UILabel!
    @IBOutlet weak var fansStatusButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
