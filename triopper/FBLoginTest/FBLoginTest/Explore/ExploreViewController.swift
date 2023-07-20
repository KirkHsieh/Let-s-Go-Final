//
//  ExploreViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/14.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ExploreViewController: UIViewController, UITabBarDelegate, UITableViewDataSource,Trips_Explore_ReturnDelegate {

    var explorePhoto: [UIImage] = [#imageLiteral(resourceName: "首頁1"), #imageLiteral(resourceName: "首頁2"), #imageLiteral(resourceName: "首頁3"), #imageLiteral(resourceName: "首頁4"), #imageLiteral(resourceName: "首頁5"), #imageLiteral(resourceName: "首頁6")]
    var tags: [Bool] = [false, true, false, true, false, true, false]
    
    
    @IBOutlet weak var aiv: UIActivityIndicatorView!
    @IBOutlet weak var exploreTableView: UITableView!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalExploreTripData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "exploreCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExploreTableViewCell
        cell.exploreImage?.image = explorePhoto[indexPath.row]
        cell.exploreNameLabel?.text = globalExploreTripData?[indexPath.row].name
        cell.exploreTimeLocationLabel?.text = (globalExploreTripData?[indexPath.row].place)! + "\n" + stripDateTime(wordArray: (globalExploreTripData?[indexPath.row].startDate)!) + "~" + stripDateTime(wordArray: (globalExploreTripData?[indexPath.row].endDate)!)
        cell.relaxTagButton.layer.cornerRadius = 5
        cell.relaxTagButton.setTitle("\((globalExploreTripData?[indexPath.row].tag?[0])!)", for: .normal)
        cell.lightTripTagButton.layer.cornerRadius = 5
        cell.lightTripTagButton.setTitle("\((globalExploreTripData?[indexPath.row].tag?[1])!)", for: .normal)
//        if tags[indexPath.row] == true {
//            cell.relaxTagButton.isHidden = false
//            cell.lightTripTagButton.isHidden = false
//        }
//        else {
//            cell.relaxTagButton.isHidden = true
//            cell.lightTripTagButton.isHidden = true
//        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)]
        
        aiv.hidesWhenStopped = true //當停止spinner時隱藏spinnerUI
    }
    
    func stripDateTime(wordArray:String) -> String {
        
        var wordStart = wordArray.index(wordArray.startIndex, offsetBy: 5)
        var wordEnd = wordArray.index(wordStart, offsetBy: 5)
        var Word = wordArray[wordStart..<wordEnd]
        
        let start = Word.index(Word.startIndex, offsetBy: 2);
        let end = Word.index(Word.startIndex, offsetBy: 3);
        Word.replaceSubrange(start..<end, with: "/")
        return String(Word)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        aiv.startAnimating()
        
        let trip = Trip()
        trip.explore_delegate = self
        trip.getExploreTrip() // 背地裡是Async
        // 這裡不會馬上有資料
    }
    
    func didFinishDownloading(_sender: Trips_Explore_Return) {
        // 這裡才是真的有資料
        aiv.stopAnimating()
        globalExploreTripData = _sender.trip
        self.exploreTableView.reloadData()
        
    }

}

