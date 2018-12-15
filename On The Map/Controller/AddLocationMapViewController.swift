//
//  AddLocationMapViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/17/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var request = MKLocalSearch.Request()
    var locationString : String?
    var website : String?
    var lat : Double!
    var long : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Location"
        finishButton.layer.cornerRadius = 5
        finishButton.clipsToBounds = true
        request.naturalLanguageQuery = locationString
        map.delegate = self
        let search = MKLocalSearch(request: request)
        activityIndicator.startAnimating()
        search.start(completionHandler: {(response, error) in
            self.activityIndicator.stopAnimating()
            if error != nil {
                print("Could Not Find Location: \(self.locationString)")
                self.presentAlarm(message: "Could Not Find Location: \(self.locationString)")
            } else if response!.mapItems.count == 0 {
                print("Could Not Find Location: \(self.locationString)")
                self.presentAlarm(message: "Could Not Find Location: \(self.locationString)")
            } else {
                let item = response?.mapItems[0]
                let annotation = MKPointAnnotation()
                annotation.coordinate = item!.placemark.coordinate
                annotation.title = item!.name
                annotation.title = self.locationString
                self.lat = item!.placemark.coordinate.latitude
                self.long = item!.placemark.coordinate.longitude
                self.map.addAnnotation(annotation)
                self.map.region = (response?.boundingRegion)!
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    @IBAction func addLocation(_ sender: Any) {
        activityIndicator.startAnimating()
        let manager = ParseNetworkingManager()
        manager.postLocation(mapString: locationString!, mediaURL: website!, latitude: lat, longitude: long) { (error) in
            self.activityIndicator.stopAnimating()
            if let error = error{
                self.presentAlarm(message: error);
            }else{
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func presentAlarm(message : String){
        let alarm = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alarm, animated: true)
    }
    
    
}
