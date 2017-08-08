//
//  ViewController.swift
//  test
//
//  Created by Artem Mkrtchyan on 8/8/17.
//  Copyright © 2017 Artem Mkrtchyan. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController, LoginButtonDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .custom("user_photos") ])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AccessToken.current != nil {
            performSegue(withIdentifier: "showAlbumsList", sender: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
        print(result)
        switch result {
        case .success( _, _, _):
            performSegue(withIdentifier: "showAlbumsList", sender: nil)
            break
        case .cancelled:
            print("canceled")
            break
        case .failed(let error):
            print(error)
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
}

