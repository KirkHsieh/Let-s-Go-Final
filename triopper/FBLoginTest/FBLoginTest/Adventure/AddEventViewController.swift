//
//  addEventViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/5.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate , UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var addEventTableView: UITableView!
    @IBOutlet var tagsView: UIView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var tagsPickerView: UIPickerView!
    
    var eventAttribute: [String] = ["名稱", "開始時間", "結束時間", "地點", "內容", "活動隱私", "報名截止日期", "人數限制", "Tags"]
    var eventContent: [String] = ["一起郊遊吧！", "107/04/21", "107/04/22", "台東", "旅遊詳情", "公開設定 >", "107/04/10", "10", "點即可多次選擇"]
    var hashTags: [String] = ["環島", "輕鬆", "趣味", "水上", "遊樂園", "懷舊風", "大自然", "網美行程", "邊走邊吃", "美食之旅", "冒險系列", "運動系列", "文藝青年", "驚險恐怖", "成雙成對", "古蹟之旅", "景點包你滿意", "私房景點大公開", "副駕駛isyou", "安全帽屬於你", "11號公車", "shoppingmall"]
    
    var tagsTextFieldText: String = "點擊可多次選擇"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventAttribute.count
    }
    
    let tags: hashTag = hashTag()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "addEventCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AddEventTableViewCell
        cell.eventAttributeLabel?.text = eventAttribute[indexPath.row]
        cell.eventContentTextField?.text = eventContent[indexPath.row]
        
        if indexPath.row == 5 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.setPrivateFunction))
            cell.eventContentTextField.isUserInteractionEnabled = true
            cell.eventContentTextField.addGestureRecognizer(tap)
        }
        if(indexPath.row == 8) {
            cell.eventContentTextField.delegate = self
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.selectClick))
            cell.eventContentTextField.isUserInteractionEnabled = true
            cell.eventContentTextField.addGestureRecognizer(tap)
            cell.eventContentTextField?.text = tagsTextFieldText
        }
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hashTags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hashTags[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Trip"
        
        let button = UIButton(type: .custom)
        button.setTitle("  Save  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.layer.cornerRadius = 5
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 2
        button.tintColor = .white
        button.addTarget(self, action: #selector(saveAdventure), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        maskView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(tagsView)
        tagsView.translatesAutoresizingMaskIntoConstraints = false
        
        tagsView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        tagsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tagsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let pickerBottomConstraint = tagsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 220)
        pickerBottomConstraint.identifier = "pickerBottom"
        pickerBottomConstraint.isActive = true
        super.viewWillAppear(animated)
    }
    @IBAction func doneClick(_ sender: Any) {
        maskView.isHidden = true
        for constraint in view.constraints {
            if constraint.identifier == "pickerBottom" {
                constraint.constant = 220
                
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        var didSelectedTag = tagsPickerView.selectedRow(inComponent: 0)
        tags.add(tagName: hashTags[didSelectedTag])
        tagsTextFieldText =  tags.description
        hashTags.remove(at: didSelectedTag)
        tagsPickerView.reloadComponent(0)
        addEventTableView.reloadData()
    }
    
    @objc func selectClick(_ sender: Any?) {
        maskView.isHidden = false
        for constraint in view.constraints {
            if constraint.identifier == "pickerBottom" {
                constraint.constant = -10
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        maskView.isHidden = true
        for constraint in view.constraints {
            if constraint.identifier == "pickerBottom" {
                constraint.constant = 220
                
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    @objc func setPrivateFunction(sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "setPrivateSegue", sender: self)
    }
    @objc func saveAdventure(sender: UITapGestureRecognizer) {
        print("press saveAdventure button")
        let trip = Trip()
        trip.createTrip()
    }
}
