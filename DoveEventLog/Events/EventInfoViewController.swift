//
//  EventInfoViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 8/24/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit
import EventKit

class EventInfoViewController: UIViewController {
    
    @IBOutlet var eventName: UITextField!
    @IBOutlet var eventLocName: UITextField!
    @IBOutlet var eventLocAddress: UITextField!
    @IBOutlet var eventLocCity: UITextField!
    @IBOutlet var eventLocState: UITextField!
    @IBOutlet var eventDate: UITextField!
    @IBOutlet var eventTime: UITextField!
    @IBOutlet var eventComments: UITextView!
    @IBOutlet var eventLocDirector: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editDatePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = false
            popup.onSave = { (data) in
                self.eventDate.text = data
            }
            }
        
        if (segue.identifier == "editTimePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = true
            popup.onSave = { (Data) in
                self.eventTime.text = Data
            }
        }
    }
    
    
    @IBAction func eventInfoSave(_ sender: AnyObject) {
        
        //hack
        let url = URL(string: "http://davestucky.com/funeralAdd.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let newEvent = TblEventsInfo(eventkey: eventName.text!, eventname: eventName.text!, eventdate: (eventDate?.text!)!, eventtime: (eventTime?.text!)!, locname: eventLocName.text!, locaddress: eventLocAddress.text!, loccity: eventLocCity.text!, locstate: eventLocState.text!, eventcontactname: eventLocDirector.text!, specialinstructions: eventComments.text!, eventcalID: savedEventId)
        
        // newEvent.saveItem()
        
//        request.httpBody = newEvent.data(using: String.Encoding.utf8)
//
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {
//            data, response, error in
//
//            if error != nil {
//                print("error=\(String(describing: error))")
//                return
//            }
//
//            print("response = \(String(describing: response))")
//
//            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("responseString = \(String(describing: responseString))")
//        })
//        task.resume()
    }
    
    


}

