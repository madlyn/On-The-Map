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
    var request = MKLocalSearch.Request()
    
    var locationString : String?
    var website : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Location"
        finishButton.layer.cornerRadius = 5
        finishButton.clipsToBounds = true
        request.naturalLanguageQuery = locationString
        map.delegate = self
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Could Not Find Location: \(self.locationString)")
            } else if response!.mapItems.count == 0 {
                print("Could Not Find Location: \(self.locationString)")
            } else {
                let item = response?.mapItems[0]
                let annotation = MKPointAnnotation()
                annotation.coordinate = item!.placemark.coordinate
                annotation.title = item!.name
                annotation.title = self.locationString
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
    
}
