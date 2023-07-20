//
//  FollowViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/1.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class FollowViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var followPhoto: [UIImage] = [#imageLiteral(resourceName: "蘇昱齊"), #imageLiteral(resourceName: "謝進益"), #imageLiteral(resourceName: "蔡冠玗"), #imageLiteral(resourceName: "劉子儀"), #imageLiteral(resourceName: "陳紫寧"), #imageLiteral(resourceName: "洪嘉吟")]
    var followName: [String] = ["蘇昱齊", "謝進益", "蔡冠玗", "劉子儀", "陳紫寧", "洪嘉吟"]
    var followStatusPhoto: [UIImage] = [#imageLiteral(resourceName: "追蹤中")]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "followCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FollowTableViewCell
        cell.followPhotoImage?.image = followPhoto[indexPath.row]
        cell.followPhotoImage.layer.cornerRadius = cell.followPhotoImage.frame.height / 2.0
        cell.followPhotoImage.layer.masksToBounds = true
        cell.followNameLabel?.text = followName[indexPath.row]
        cell.followStatusButton.setTitle("追蹤中", for: UIControlState.normal)
        cell.followStatusButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.followStatusButton.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: UIControlState.normal)
        cell.followStatusButton.layer.borderWidth = 2
        cell.followStatusButton.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        cell.followStatusButton.layer.cornerRadius = 5
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "追蹤名單"
        // Do any additional setup after loading the view.
    }
}
