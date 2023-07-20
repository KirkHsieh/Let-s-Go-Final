//
//  EditProfileViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/5/2.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var introductionTextField: UITextField!
    @IBOutlet weak var hobbyTextField: UITextField!//tag,do not use
    @IBOutlet weak var personalityTextField: UITextField!//tag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "編輯個人檔案"
        let button = UIButton(type: .custom)
        button.setTitle("  儲存  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.layer.cornerRadius = 5
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 2
        button.tintColor = .white
        button.addTarget(self, action: #selector(saveProfile), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)]
        // Do any additional setup after loading the view.
    }
    
    @objc func saveProfile() {
        //click save button then store the user data to User_return.
        
        let profile = Profile()
        profile.updateUserData(name: userNameTextField.text!,location: locationTextField.text!,email: emailTextField.text!,introduction: introductionTextField.text!)
        //用if/else來判斷State code，如果判斷存值成功，在執行跳頁動作並reload。
        navigationController?.popViewController(animated: true)
        //todo : After store , ProfileViewController needs to be refresh.
    }
}
