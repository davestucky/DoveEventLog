//
//  SunShineTime.swift
//  WUAD Wedding App
//
//  Created by Dave Stucky on 7/28/16.
//  Copyright © 2016 Dave Stuckenschneider. All rights reserved.
//

import Foundation
import UIKit

class SunSetGetter: UIViewController{
    
    @IBOutlet var sunDown: UITextField!
    @IBOutlet var lastLightDark: UITextField!
    @IBOutlet var wedDate: UITextField!
    var sunRise = Date()
    var sunSet = Date()
    var futureDate = ""
    var today = Date()
    @IBOutlet var sunsetDatePicker: UIDatePicker!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        wedDate.text = formatter.string(from:sunsetDatePicker.date)
                
        getSunTimes()
        
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        getSunTimes()
    }
    
    
    func getSunTimes(){
        
        let myLat = UserDefaults.standard.double(forKey: "loftLat")
        let myLong = UserDefaults.standard.double(forKey: "loftLong")
        
        futureDate = wedDate.text!
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateFromString = dateFormatter.date(from: futureDate)
            
        let solar = Solar(forDate: dateFromString!,withTimeZone: TimeZone(identifier: "CST")!, latitude: myLat, longitude: myLong)
        
        let sunSet = solar!.sunset
        let lastLight = solar?.civilSunset
        
        let dateFormatterSunTimes = DateFormatter()
        dateFormatterSunTimes.dateStyle = .none
        dateFormatterSunTimes.timeStyle = .short
        dateFormatterSunTimes.timeZone = TimeZone.autoupdatingCurrent
        let timeStampDown = dateFormatterSunTimes.string(from: sunSet!)
        let timeStampLast = dateFormatterSunTimes.string(from: lastLight!)
        
        sunDown.text = timeStampDown
        lastLightDark.text = timeStampLast
        
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            self.view.endEditing(true)
        }
    }
    
    @IBAction func dateSelectedFromDatePicker(_ sender: AnyObject) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        wedDate.text = formatter.string(from:sunsetDatePicker.date)
    }
}
