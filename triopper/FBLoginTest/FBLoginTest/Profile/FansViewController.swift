//
//  FansViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/1.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class FansViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var fansPhoto: [UIImage] = [#imageLiteral(resourceName: "蘇昱齊"), #imageLiteral(resourceName: "謝進益"), #imageLiteral(resourceName: "蔡冠玗"), #imageLiteral(resourceName: "劉子儀"), #imageLiteral(resourceName: "陳紫寧"), #imageLiteral(resourceName: "洪嘉吟")]
    var fansName: [String] = ["蘇昱齊", "謝進益", "蔡冠玗", "劉子儀", "陳紫寧", "洪嘉吟"]
    var fansStatus: [Bool] = [false, true, true, false, false, false]
    var fansStatusPhoto: [UIImage] = [#imageLiteral(resourceName: "追蹤中"), #imageLiteral(resourceName: "追蹤")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fansName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "fansCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FansTableViewCell
        cell.fansPhotoImage?.image = fansPhoto[indexPath.row]
        cell.fansPhotoImage.layer.cornerRadius = cell.fansPhotoImage.frame.height / 2.0
        cell.fansPhotoImage.layer.masksToBounds = true
        cell.fansNameLabel?.text = fansName[indexPath.row]
        if fansStatus[indexPath.row] == true {
            cell.fansStatusButton.setTitle("追蹤中", for: UIControlState.normal)
            cell.fansStatusButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.fansStatusButton.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: UIControlState.normal)
            cell.fansStatusButton.layer.borderWidth = 2
            cell.fansStatusButton.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            cell.fansStatusButton.layer.cornerRadius = 5
        }
        else {
            cell.fansStatusButton.setTitle("追蹤", for: UIControlState.normal)
            cell.fansStatusButton.layer.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            cell.fansStatusButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
            cell.fansStatusButton.layer.borderWidth = 2
            cell.fansStatusButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            cell.fansStatusButton.layer.cornerRadius = 5
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "粉絲名單"
        
        
        // Do any additional setup after loading the view.
    }
}
