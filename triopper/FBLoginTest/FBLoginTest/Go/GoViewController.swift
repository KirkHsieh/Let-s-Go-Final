//
//  GoViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/14.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class GoViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {

    var goPhoto: [UIImage] = [#imageLiteral(resourceName: "adVenturePhoto1"), #imageLiteral(resourceName: "adVenturePhoto2"), #imageLiteral(resourceName: "adVenturePhoto3"), #imageLiteral(resourceName: "adVenturePhoto4")]
    var goName: [String] = ["Let's go BBQ! Chat&Share", "Let's go BBQ! Chat&Share", "Let's go BBQ! Chat&Share", "Let's go BBQ! Chat&Share"]
    var goTimeLocation: [String] = ["4/21-4/23 台東", "4/21-4/23 台東", "4/21-4/23 台東", "4/21-4/23 台東"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "goCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GoTableViewCell
        cell.goImage?.image = goPhoto[indexPath.row]
        cell.goNameLabel?.text = goName[indexPath.row]
        cell.goTimeLocationLabel?.text = goTimeLocation[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
