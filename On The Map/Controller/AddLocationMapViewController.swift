//
//  AddLocationMapViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/17/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit

class AddLocationMapViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        finishButton.layer.cornerRadius = 5
        finishButton.clipsToBounds = true
    }

}
