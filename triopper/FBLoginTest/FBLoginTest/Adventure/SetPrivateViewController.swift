//
//  SetPrivateViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/5.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class SetPrivateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var privacyItem: [String] = ["公開", "顯示給訂閱者"]
    var checkNumber = 0
    
    @IBOutlet weak var privacyItemTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privacyItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "privacyItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SetPrivateTableViewCell
        cell.privacyItemLabel?.text = privacyItem[indexPath.row]
        cell.checkButton.isHidden = false
//        if indexPath.row == 0 {
//            let tap = UITapGestureRecognizer(target: self, action: #selector(SetPrivateViewController.setPrivateFunction_1))
//            cell.checkButton.isUserInteractionEnabled = true
//            cell.checkButton.addGestureRecognizer(tap)
//            if checkNumber == 1 {
//                cell.checkButton.isHidden = false
//            }
//            else {
//                cell.checkButton.isHidden = true
//            }
//        }
//        if indexPath.row == 1 {
//            let tap = UITapGestureRecognizer(target: self, action: #selector(SetPrivateViewController.setPrivateFunction_2))
//            cell.checkButton.isUserInteractionEnabled = true
//            cell.checkButton.addGestureRecognizer(tap)
//            if checkNumber == 2 {
//                cell.checkButton.isHidden = false
//            }
//            else {
//                cell.checkButton.isHidden = true
//            }
//        }
//        if indexPath.row == 2 {
//            let tap = UITapGestureRecognizer(target: self, action: #selector(SetPrivateViewController.setPrivateFunction_3))
//            cell.checkButton.isUserInteractionEnabled = true
//            cell.checkButton.addGestureRecognizer(tap)
//            if checkNumber == 3 {
//                cell.checkButton.isHidden = false
//            }
//            else {
//                cell.checkButton.isHidden = true
//            }
//        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "活動隱私設定"
        privacyItemTableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func setPrivateFunction_1(sender:UITapGestureRecognizer) {
        self.checkNumber = 1
    }
    @objc func setPrivateFunction_2(sender:UITapGestureRecognizer) {
        self.checkNumber = 2
    }
    @objc func setPrivateFunction_3(sender:UITapGestureRecognizer) {
        self.checkNumber = 3
    }
}
