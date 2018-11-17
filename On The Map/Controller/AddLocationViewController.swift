//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/17/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var websiteTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findLocationButton.layer.cornerRadius = 5
        findLocationButton.clipsToBounds = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func findLocation(_ sender: Any) {
        if (locationTextfield.text?.isEmpty)!{
            showAlert(message: "Please Enter a Location")
           return
        }
        if (websiteTextfield.text?.isEmpty)!{
            showAlert(message: "Please Enter a Website")
            return
        }
        if !(websiteTextfield.text?.contains("http"))!{
            showAlert(message: "Please Enter a valid Website that includes HTTP")
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "locationMapVC") as! AddLocationMapViewController
        vc.locationString = locationTextfield.text
        vc.website = websiteTextfield.text
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
