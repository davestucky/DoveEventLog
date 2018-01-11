//
//  venueMapViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/3/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class venueMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    
    let locationhome = "2924 Ossenfor Rd, Wildwood, MO"
    
    @IBOutlet var mapRandomVenueName: UITextField!
    @IBOutlet var mapRandomVenue: UITextField!
    var locationVenue: String = ""
    var venueName: String = ""
    var geocoder:CLGeocoder = CLGeocoder()
    var geocoderhome:CLGeocoder = CLGeocoder()
    var radiusHome = 56327 as Double
    @IBOutlet var mapView: MKMapView!
    //mapView?.delegate = self
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We use a predefined location
        let location = CLLocation(latitude: 38.57 as CLLocationDegrees, longitude: -90.71 as CLLocationDegrees)
        
        addRadiusCircle(location)
        findHomeLocation()
        findVenueLocation()
    }
    
    func addRadiusCircle(_ location: CLLocation){
        self.mapView?.delegate = self
        let circle = MKCircle(center: location.coordinate, radius: 56327 as CLLocationDistance)
        self.mapView?.add(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let circle = MKCircleRenderer(overlay: overlay)
        circle.strokeColor = UIColor.red
        circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
        circle.lineWidth = 1
        return circle
            }
    
    func findHomeLocation(){
        
        
        geocoderhome.geocodeAddressString(locationhome, completionHandler: {(placemarkshome, error) -> Void in
            
            if((error) != nil){
                
                print("Error", error as Any)
            }
                
            else if let placemarkhome = placemarkshome?.first {
                
                let coordinateshome:CLLocationCoordinate2D = placemarkhome.location!.coordinate
                var locManagerhome:CLLocationManager!
                let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                
                pointAnnotation.coordinate = coordinateshome
                pointAnnotation.title = "WUAD Home"
                pointAnnotation.subtitle = "Red Circle = 35 mile radius"
                
                self.mapView?.addAnnotation(pointAnnotation)
                self.mapView?.centerCoordinate = coordinateshome
                self.mapView?.selectAnnotation(pointAnnotation, animated: true)
                
                
                locManagerhome = CLLocationManager()
                locManagerhome.desiredAccuracy = kCLLocationAccuracyBest
                let spanhome = MKCoordinateSpanMake(0.99, 0.99)
                let regionhome = MKCoordinateRegion(center: coordinateshome, span: spanhome)
                
                self.mapView?.setRegion(regionhome, animated: true)
                
                
            }
            
        })
        
    }
    
    func findVenueLocation(){
        let location = locationVenue
        let ven = "Your Venue"
        
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
            
            if((error) != nil){
                
                print("Error", error as Any)
            }
                
            else if let placemark = placemarks?.first {
                
                //var placemark:CLPlacemark = placemarks[0] as! CLPlacemark
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                var locManager:CLLocationManager!
                let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinates
                pointAnnotation.title = ven
                
                self.mapView?.addAnnotation(pointAnnotation)
                self.mapView?.centerCoordinate = coordinates
                self.mapView?.selectAnnotation(pointAnnotation, animated: true)
                
                
                locManager = CLLocationManager()
                locManager.desiredAccuracy = kCLLocationAccuracyBest
                let span = MKCoordinateSpanMake(0.99, 0.99)
                let region = MKCoordinateRegion(center: coordinates, span: span)
                
                self.mapView?.setRegion(region, animated: true)
                
                
                
                
            }
            
        })
        
        
        
    }
    
    
    
    @IBAction func mapItPressed(_ sender: UIButton) {
        locationVenue = mapRandomVenue.text!
        venueName = mapRandomVenueName.text!
        findVenueLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
