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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        if (emailTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)!{
            showAlarm(message: "Empty email/password fields")
            return
        }
        activityIndicator.startAnimating()
        let manager = UdacityNetworkingManager()
        manager.login(email: emailTextfield.text!, password: passwordTextfield.text!) { (id, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            if let error = error{
                DispatchQueue.main.async {
                    self.showAlarm(message: error)
                }
            } else{
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    func showAlarm(message : String){
        let alarm = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alarm, animated: true, completion: nil)
    }
    
}

