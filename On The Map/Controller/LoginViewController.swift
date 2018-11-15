//
//  ViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/15/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // rounded corners
        logInButton.layer.cornerRadius = 5
        logInButton.clipsToBounds = true
    }

    @IBAction func signUpPressed(_ sender: Any) {
        guard let url = URL(string: "https://auth.udacity.com/sign-up") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
    }
    
    
}

