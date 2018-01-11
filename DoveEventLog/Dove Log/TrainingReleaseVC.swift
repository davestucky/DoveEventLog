//
//  TrainingReleaseVC.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/24/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class TrainingReleaseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    var compasstext: String = ""
    let myLat = UserDefaults.standard.double(forKey: "loftLat")
    let myLong = UserDefaults.standard.double(forKey: "loftLong")
    var compass: Double = 0.0
    var distance: Double = 0.0
    var distanceDB: String! = ""
    var feetmiles: String! = ""
    var releaseLocationManager = CLLocationManager()
    let homeAnno = MKPointAnnotation()
    let relAnno = MKPointAnnotation()
    var values:NSArray = []
    var stuff  = NSMutableArray()
    var chartTeam: String! = "red"
    @IBOutlet var releaseMap: MKMapView!
    @IBOutlet var distanceRelease: UILabel!
    @IBOutlet var teamPicker: UIPickerView!
    var currentlocation:CLLocation?
    @IBOutlet var savedClassButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.teamPicker.reloadAllComponents()
        getTeamKeys()
        chartTeam = stuff[0] as! String
        savedClassButton.backgroundColor = UIColor.red
        getWUADLoc()
        releaseLocationManager.startUpdatingLocation()
    }
    
    func getWUADLoc(){
        let homeLocation = CLLocationCoordinate2DMake(myLat, myLong)
        self.releaseLocationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            releaseLocationManager.delegate = self
            releaseLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
        }
        
        let releaseSpan = MKCoordinateSpanMake(0.95, 0.95)
        let releaseRegion = MKCoordinateRegion( center: homeLocation, span: releaseSpan)
        releaseMap.setRegion(releaseRegion, animated: true)
        self.releaseMap.setRegion(releaseRegion, animated: true)
        releaseLocationManager.delegate = self
        releaseLocationManager.requestWhenInUseAuthorization()
        homeAnno.coordinate = homeLocation
        homeAnno.title = "WUAD Loft"
        releaseMap.addAnnotation(homeAnno)
        
        releaseLocationManager.stopUpdatingLocation()
    }
    
    
    func locationManager( _ releaseLocationManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(releaseLocationManager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks?.first
                
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        let homeLocationLatLong = CLLocation(latitude: myLat, longitude: myLong)
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            let hereLat = (containsPlacemark.location!.coordinate.latitude.description as NSString).doubleValue
            let hereLong = (containsPlacemark.location!.coordinate.longitude.description as NSString).doubleValue
            let relLocation = CLLocation(latitude: hereLat , longitude: hereLong)
            let annoCoor = CLLocationCoordinate2D(latitude: hereLat, longitude: hereLong)
            relAnno.coordinate = annoCoor
            relAnno.title = "Release Location"
            
            releaseMap.addAnnotation(relAnno)
            //var distance = homeLocationLatLong.distance(from: relLocation)
            distance = homeLocationLatLong.distance(from: relLocation)
                distance = distance * 0.000621371192
            
           //var compass: Double
            compass = getBearingBetweenTwoPoints1(homeLocationLatLong, point2: relLocation)
            compass = compass + 180.00
            if compass > 360.00 {
                compass = compass - 180.00
            }
           // let compasstext = windDirectionFromDegrees(compass)
            compasstext = windDirectionFromDegrees(compass)
            self.distanceRelease.text = "Class=\(chartTeam!) " +  (NSString(format:"%.01f miles to Loft  " as NSString, distance) as String) as String
            self.distanceRelease.text = distanceRelease.text! + " Direction= \(compasstext)"
            distanceDB = String(format:"%.01f", distance) + "miles / " + compasstext
        }
        releaseLocationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    // Mark Direction of release
    func degreesToRadians(_ degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(_ radians: Double) -> Double { return radians * 180.0 / .pi }
    
    func getBearingBetweenTwoPoints1(_ point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let lat1 = degreesToRadians(point1.coordinate.latitude)
        let lon1 = degreesToRadians(point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(point2.coordinate.latitude);
        let lon2 = degreesToRadians(point2.coordinate.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return radiansToDegrees(radiansBearing)
    }
    //mark end
    
    //mark degrees to compass text
    func windDirectionFromDegrees(_ degrees: Double) -> String {
        var hour1WindDirection: String
        if (348.75 <= degrees && degrees <= 360) {
            hour1WindDirection = "North   "
        } else if (0 <= degrees && degrees <= 11.25) {
            hour1WindDirection = "North   ";
        } else if (11.25 < degrees && degrees <= 33.75) {
            hour1WindDirection = "NorthNE ";
        } else if (33.75 < degrees && degrees <= 56.25) {
            hour1WindDirection = "North E ";
        } else if (56.25 < degrees && degrees <= 78.75) {
            hour1WindDirection = "East NE ";
        } else if (78.75 < degrees && degrees <= 101.25) {
            hour1WindDirection = "East    ";
        } else if (101.25 < degrees && degrees <= 123.75) {
            hour1WindDirection = "East SE ";
        } else if (123.75 < degrees && degrees <= 146.25) {
            hour1WindDirection = "South E ";
        } else if (146.25 < degrees && degrees <= 168.75) {
            hour1WindDirection = "SouthSE ";
        } else if (168.75 < degrees && degrees <= 191.25) {
            hour1WindDirection = "South   ";
        } else if (191.25 < degrees && degrees <= 213.75) {
            hour1WindDirection = "SouthSW ";
        } else if (213.75 < degrees && degrees <= 236.25) {
            hour1WindDirection = "SouthW  ";
        } else if (236.25 < degrees && degrees <= 258.75) {
            hour1WindDirection = "WestSW  ";
        } else if (258.75 < degrees && degrees <= 281.25) {
            hour1WindDirection = "West    ";
        } else if (281.25 < degrees && degrees <= 303.75) {
            hour1WindDirection = "WestNW  ";
        } else if (303.75 < degrees && degrees <= 326.25) {
            hour1WindDirection = "NorthW  ";
        } else if (326.25 < degrees && degrees < 348.75) {
            hour1WindDirection = "NorthNW ";
        } else {
            hour1WindDirection = "unknown ";
        }
        return hour1WindDirection
    }
    
    @IBAction func classCommentPressed(_ sender: AnyObject) {
        // Mark Get The Class Members and Post Class Train Release Info
        let dateDB = Date()
        let dateFormatterDB = DateFormatter()
        dateFormatterDB.dateFormat = "yyyy-MM-dd" 
        let dateStringDB = dateFormatterDB.string(from: dateDB)
        /*let myUrlCM = URL(string: "http://davestucky.com/birdworks4.php");
        let requestCM = NSMutableURLRequest(url:myUrlCM!);
        requestCM.httpMethod = "POST";// Compose a query string
        let postStringCM = "date=\(dateStringDB)&desc=\(distanceDB)";
        requestCM.httpBody = postStringCM.data(using: String.Encoding.utf8);
        let taskCM = URLSession.shared.dataTask(with: requestCM as URLRequest) {
            dataCM, responseCM, errorCM in
            if errorCM != nil
            {
                print("error=\(String(describing: errorCM))")
                return
            }
            // You can print out response object
            print("response = \(responseCM!)")
            // Print out response body
            let responseStringCM = NSString(data: dataCM!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseStringCM!)")
            //Let's convert response sent from a server side script to a NSArray object:
            do {
                let myJSONCM =  try JSONSerialization.jsonObject(with: dataCM!, options: .mutableContainers) as? NSArray
                
                if let parseJSONCM = myJSONCM {
                    
                    for row in (parseJSONCM  as? [[String:Any]])! {
                        
                        let teamMember = row["band_no"]
                        let longname = teamMember!
                        let request = NSMutableURLRequest(url: URL(string: "http://davestucky.com/birdtest.php")!)
                        request.httpMethod = "POST"
                        let postString = "band=\(longname)&date=\(dateStringDB)&desc=\(self.distanceRelease.text!)"
                        request.httpBody = postString.data(using: String.Encoding.utf8)
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest) {
                            data, response, error in
                            
                            if error != nil {
                                print("error=\(String(describing: error))")
                                return
                            }
                            
                            print("response = \(String(describing: response))")
                            
                            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            print("responseString = \(responseString!)")
                            
                        }
                        task.resume()
                    }
                }
            }catch {
                print(error)
            }
        }
        taskCM.resume()*/
        
        let requestDB = NSMutableURLRequest(url: URL(string: "http://davestucky.com/birdtrainmiles.php")!)
        requestDB.httpMethod = "POST"
        let postStringDB = "class=\(chartTeam!)&date=\(dateStringDB)&desc=\(distanceDB!)"
        requestDB.httpBody = postStringDB.data(using: String.Encoding.utf8)
        let taskDB = URLSession.shared.dataTask(with: requestDB as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            print("response = \(response!)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString!)")
        }
        
        taskDB.resume()
        savedClassButton.backgroundColor = UIColor.green
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {self.savedClassButton.backgroundColor = UIColor.red})
        
    }
    
    //MARK - fill picker view with teamColor
    func getTeamKeys(){
        let url = URL(string: "http://davestucky.com/birdworks3.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let teamColor = row["class_band"]
            let longname = teamColor!
            stuff.add(longname)
            
        }
        
    }
    
    //MARK - Team Picker View Stuff
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return stuff.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return (stuff[row] as! String)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let itemSelected: String = stuff[row] as! String
        chartTeam = itemSelected
        
        self.distanceRelease.text = "Class  \(chartTeam!) " +  (NSString(format:"%.01f miles to Loft  " as NSString, distance) as String) as String
        self.distanceRelease.text = distanceRelease.text! + "  Direction = \(compasstext)"
        distanceDB = String(format:"%.01f", distance) + "miles / " + compasstext
        
        
    }
    
    //TPV end
   
    
}


