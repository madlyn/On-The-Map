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
    override func viewDidLoad() {
        super.viewDidLoad()
        findLocationButton.layer.cornerRadius = 5
        findLocationButton.clipsToBounds = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
