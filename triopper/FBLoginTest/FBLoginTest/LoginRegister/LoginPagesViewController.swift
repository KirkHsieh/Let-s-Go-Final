//
//  LoginPagesViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/3/28.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class LoginPagesViewController: UIViewController {

    @IBAction func nextPageAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
