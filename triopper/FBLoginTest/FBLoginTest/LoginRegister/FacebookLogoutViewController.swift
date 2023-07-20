//
//  FacebookLogoutViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/3/21.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FacebookLogoutViewController: UIViewController {

    @IBAction func logoutAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "logoutSuccessSegue", sender: self)
        print("logout Success")
        print()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
