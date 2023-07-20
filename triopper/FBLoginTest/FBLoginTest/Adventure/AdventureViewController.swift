//
//  AdventureViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/4.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class AdventureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,Trips_Adventure_ReturnDelegate {

    var adventurePhoto: [UIImage] = [#imageLiteral(resourceName: "adVenturePhoto1"), #imageLiteral(resourceName: "adVenturePhoto2"), #imageLiteral(resourceName: "adVenturePhoto3"), #imageLiteral(resourceName: "adVenturePhoto4")]
    var adventureName: [String] = ["Let's go BBQ! Chat&Share", "Let's go BBQ! Chat&Share", "Let's go BBQ! Chat&Share", "Let's go BBQ! Chat&Share"]
    var adventureTimeLocation: [String] = ["4/21-4/23 台東", "4/21-4/23 台東", "4/21-4/23 台東", "4/21-4/23 台東"]

    @IBOutlet weak var aiv: UIActivityIndicatorView!
    @IBOutlet weak var adventureTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalAdventureTripData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "adventureCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AdventureTableViewCell
        cell.adventureImage?.image = adventurePhoto[indexPath.row]
        cell.adventureNameLabel?.text = adventureName[indexPath.row]
        cell.adventureNameLabel?.text = globalAdventureTripData?[indexPath.row].name
        cell.adventureTimeLocationLabel?.text =  globalAdventureTripData?[indexPath.row].place
//        cell.layer.cornerRadius = 6.0
//        cell.layer.borderWidth = 2.0
//        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)]
        // Do any additional setup after loading the view.
        aiv.hidesWhenStopped = true
    }
    override func viewWillAppear(_ animated: Bool) {
        aiv.startAnimating()
        print("test++")
        let trip = Trip()
        trip.adventure_delegate = self
        trip.getUserTrip()
        
    }
    
    func didFinishDownloading(_sender: Trips_Adventure_Return) {
        aiv.stopAnimating()
        globalAdventureTripData = _sender.trip
        self.adventureTableView.reloadData()
    }
}
