//
//  LocationsListViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/16/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit

class LocationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let locations = AppValues.locations{
            return locations.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! UITableViewCell
        cell.textLabel?.text = AppValues.locations[indexPath.row].firstName + " " + AppValues.locations[indexPath.row].lastName
        cell.detailTextLabel?.text = AppValues.locations[indexPath.row].mapString
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
    

}
