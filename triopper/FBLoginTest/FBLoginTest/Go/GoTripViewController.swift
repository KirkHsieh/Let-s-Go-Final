//
//  GoTripViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/4/15.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class GoTripViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "一起郊遊吧！"
        let button = UIButton(type: .custom)
        button.setTitle("  編輯  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.layer.cornerRadius = 5
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 2
        button.tintColor = .white
        button.addTarget(self, action: #selector(goToEditPage), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4117647059, green: 0.7960784314, blue: 0.9254901961, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goToEditPage(){

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
