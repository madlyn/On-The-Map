//
//  MapViewController.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/16/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locations = [StudentLocation]()
    
    var networkManager = ParseNetworkingManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let tabVC = self.tabBarController as! TabBarViewController
        tabVC.addLocationButton.action = #selector(addLocation)
        tabVC.refreshButton.action = #selector(getLocations)
        tabVC.logoutButton.action = #selector(logout)
        tabVC.addLocationButton.target = self
        tabVC.refreshButton.target = self
        tabVC.logoutButton.target = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocations()
    }
    
    @objc func getLocations(){
        networkManager.getLocations { (locations, error) in
            if let error = error{
                DispatchQueue.main.async {
                    self.showAlarm(message: error)
                }
            } else{
                AppValues.setLocations(locations: locations!)
                self.locations = locations!
                DispatchQueue.main.async {
                    self.viewPins()
                }
            }
        }
    }
    
    @objc func addLocation(){
        let nav = storyboard?.instantiateViewController(withIdentifier: "addLocationNav") as! UINavigationController
        self.present(nav, animated: true, completion: nil)
        
    }
    
    @objc func logout(){
        self.dismiss(animated: true, completion: nil)
    }
    func showAlarm(message : String){
        let alarm = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alarm, animated: true, completion: nil)
    }
    func viewPins(){
        var annotations = [MKPointAnnotation]()
        for location in locations {
            let lat = CLLocationDegrees(location.latitude as! Double)
            let long = CLLocationDegrees(location.longitude as! Double)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName!
            let last = location.lastName!
            let mediaURL = location.mediaURL!
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}
