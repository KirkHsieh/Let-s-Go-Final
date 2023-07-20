//
//  ProfileViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/3/31.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    var profilePersonalAttribute: [UIImage] = [#imageLiteral(resourceName: "GENDER"), #imageLiteral(resourceName: "country"), #imageLiteral(resourceName: "EMAIL"), #imageLiteral(resourceName: "hobby"), #imageLiteral(resourceName: "PERSON"), #imageLiteral(resourceName: "INTRO")]
    var profilePersonalContent:[UIImage] = [#imageLiteral(resourceName: "adVenturePhoto1"), #imageLiteral(resourceName: "adVenturePhoto2"), #imageLiteral(resourceName: "adVenturePhoto3"), #imageLiteral(resourceName: "adVenturePhoto4"), #imageLiteral(resourceName: "adVenturePhoto3"), #imageLiteral(resourceName: "adVenturePhoto4")]
    var profileContent: [String?] {
                return [globalUserData?.name, globalUserData?.location, globalUserData?.email,globalUserData?.hobby,globalUserData?.personality,globalUserData?.introduction]
            }
    var tabChangeNumber = 1
    @IBOutlet weak var profilePersonalNameLabel: UILabel!
    @IBOutlet weak var profilePersonalImageView: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profilePersonalButton: UIButton!
    @IBOutlet weak var profileTripHistoryButton: UIButton!
    @IBOutlet weak var profilePersonalView: UIView!
    @IBOutlet weak var profileTripHistoryView: UIView!
    
    @IBAction func personalTabChange(_ sender: Any) {
        tabChangeNumber = 1
        profilePersonalButton.setTitleColor(#colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1), for: .normal)
        profileTripHistoryButton.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
        profilePersonalView.layer.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        profileTripHistoryView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profileTableView.reloadData()
    }
    @IBAction func tripHistoryTabChange(_ sender: Any) {
        tabChangeNumber = 2
        profilePersonalButton.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
        profileTripHistoryButton.setTitleColor(#colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1), for: .normal)
        profilePersonalView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profileTripHistoryView.layer.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        profileTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsReturn = 6
        return rowsReturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if(tabChangeNumber == 1) {
            let cellIdentifier = "personalCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfilePersonalTableViewCell
            cell.profilePersonalAttributeImage?.image = profilePersonalAttribute[indexPath.row]
            cell.profilePersonalContentLabel?.text = profileContent[indexPath.row]
            if(indexPath.row == 2) {
                cell.profilePersonalContentLabel.adjustsFontSizeToFitWidth = true
            }
            if(indexPath.row == 5) {
                cell.profilePersonalContentLabel.numberOfLines = 2
                cell.profilePersonalContentLabel.adjustsFontSizeToFitWidth = true
                cell.profilePersonalContentLabel.minimumScaleFactor = 10.0;
            }
//            if(indexPath.row == 4) {
//
//            }
            
            return cell
        }
        else {
            let cellIdentifier = "tripHistoryCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileTripHistoryTableViewCell
            cell.profileTripHistoryImage?.image = profilePersonalContent[indexPath.row]
            cell.profileTripHistoryNameLabel?.text = profileContent[indexPath.row]
            
            return cell
        }
        
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        tabChangeNumber = 1
        let profile = Profile()
        profile.getUserData()
        
        let url = URL(string: "http://graph.facebook.com/\((globalUserData?.user_id)!)/picture?type=normal")
        let urlData = try! Data(contentsOf: url!)
        let personalImage = UIImage(data: urlData)

        
        profilePersonalButton.setTitleColor(#colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1), for: .normal)
        profileTripHistoryButton.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
        profilePersonalView.layer.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        profileTripHistoryView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)]
        
        profilePersonalImageView.layer.cornerRadius = 5
        
        
        profilePersonalImageView.image = personalImage
        profilePersonalNameLabel.text = globalUserData?.name
        
        dump(personalImage)
        print("==")
        dump(profilePersonalImageView)
    }
}
