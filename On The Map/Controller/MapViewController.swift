//
//  MapViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/16/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var networkManager = ParseNetworkingManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkManager.getLocations { (locations, error) in
            if let error = error{
                DispatchQueue.main.async {
                    self.showAlarm(message: error)
                }
            }else{
               AppValues.locations = locations
                DispatchQueue.main.async {
                    self.viewPins()
                }
            }
            
        }
    }
    func showAlarm(message : String){
        let alarm = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alarm, animated: true, completion: nil)
    }
    func viewPins(){
        var annotations = [MKPointAnnotation]()
        for location in AppValues.locations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(location.latitude as! Double)
            let long = CLLocationDegrees(location.longitude as! Double)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName!
            let last = location.lastName!
            let mediaURL = location.mediaURL!
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
}
