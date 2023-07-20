//
//  ViewController.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/3/17.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FacebookLoginViewController: LoginRequestViewController {

    @IBOutlet weak var loginButton: UIStackView!
    let loginRequest = LoginRequestViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(FacebookLoginViewController.tapLoginFunction))
        loginButton.isUserInteractionEnabled = true
        loginButton.addGestureRecognizer(tap)

    }
    
    @objc func tapLoginFunction(sender:UITapGestureRecognizer) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .userLocation, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_,_, let accessToken):
                self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
                self.loginRequest.loginCheck(token: accessToken.authenticationToken)
                Token.originToken = accessToken.authenticationToken
                //print("token=\(accessToken.authenticationToken)")
            }
        }
        print("tap working")
    }
    
}

