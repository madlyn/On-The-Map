//
//  LocationsListViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/16/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit

class LocationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AppValuesDelegate {
    
    @IBOutlet weak var table: UITableView!
    var locations = [StudentLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        locations = AppValues.getLocations()
        AppValues.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! UITableViewCell
        cell.textLabel?.text = locations[indexPath.row].firstName + " " + locations[indexPath.row].lastName
        cell.detailTextLabel?.text = locations[indexPath.row].mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        if let toOpen = locations[indexPath.row].mediaURL {
            app.openURL(URL(string: toOpen)!)
        }
    }
    
    func appValuesDidChange() {
        DispatchQueue.main.async {
            self.locations = AppValues.getLocations()
            self.table.reloadData()
        }
    }
    
    
    
}
