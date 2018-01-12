//
//  EventInfoEditViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 8/26/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit
import EventKit

class EventInfoEditViewController: UIViewController {
    
    var findEventKey: String!
    var find: String!
    var resultSet = NSArray()
     var values:NSArray = []
    @IBOutlet var editViewEvent: UIView!
    @IBOutlet var eventName: UITextField!
    @IBOutlet var eventLocName: UITextField!
    @IBOutlet var eventLocAddress: UITextField!
    @IBOutlet var eventLocCity: UITextField!
    @IBOutlet var eventLocState: UITextField!
    @IBOutlet var eventDate: UITextField!
    @IBOutlet var eventTime: UITextField!
    @IBOutlet var eventComments: UITextView!
    @IBOutlet var eventLocDirector: UITextField!
    @IBOutlet var eventEdit: UIButtonX!
    @IBOutlet var eventInfoSave: UIButtonX!
    @IBOutlet var reSched: UIButtonX!
    var savedEventId : String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getEventRequested()
        allTextFieldsDisabled()
        eventInfoSave.isHidden = true
        reSched.isHidden = true
       
    }
    
    func getEventRequested(){
        let url = URL(string: "http://davestucky.com/eventEditGet.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let eventkey = row["eventkey"] as? String
            let longname = eventkey
            if longname == findEventKey{
                self.eventName.text = row["eventname"] as? String
                self.eventLocName.text = row["eventlocname"] as? String
                self.eventLocAddress.text = row["eventlocaddress"] as? String
                self.eventLocCity.text = row["eventloccity"] as? String
                self.eventLocState.text = row["eventstate"] as? String
                self.eventDate.text = row["eventdate"] as? String
                self.eventTime.text = row["eventtime"] as? String
                self.eventComments.text = row["eventcomments"] as? String
                self.eventLocDirector.text  = row["eventlocdirector"] as? String
                self.savedEventId = (row["eventcalID"] as? String)!
            }
            
            
        }
    }
    
    //MARK Disable All Textfields   :
    func allTextFieldsDisabled(){
        self.eventName.isUserInteractionEnabled = false
        self.eventLocName.isUserInteractionEnabled = false
        self.eventLocAddress.isUserInteractionEnabled = false
        self.eventLocCity.isUserInteractionEnabled = false
        self.eventLocState.isUserInteractionEnabled = false
        self.eventDate.isUserInteractionEnabled = false
        self.eventTime.isUserInteractionEnabled = false
        self.eventComments.isUserInteractionEnabled = false
        self.eventLocDirector.isUserInteractionEnabled = false
        
    }
    
    //MARK Enable All Textfields   :
    func allTextFieldsEnabled(){
        self.eventName.isUserInteractionEnabled = true
        self.eventLocName.isUserInteractionEnabled = true
        self.eventLocAddress.isUserInteractionEnabled = true
        self.eventLocCity.isUserInteractionEnabled = true
        self.eventLocState.isUserInteractionEnabled = true
        self.eventDate.isUserInteractionEnabled = true
        self.eventTime.isUserInteractionEnabled = true
        self.eventComments.isUserInteractionEnabled = true
        self.eventLocDirector.isUserInteractionEnabled = true
    }
    
    @IBAction func eventInfoSave(_ sender: AnyObject) {
        
        //hack
        let url = URL(string: "http://davestucky.com/funeralAdd.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "task=event&eventKey=\(eventName.text!)&eventName=\(eventName.text!)&eventLocName=\(eventLocName.text!)&eventLocAddress=\(eventLocAddress.text!)&eventLocCity=\(eventLocCity.text!)&eventState=\(eventLocState.text!)&eventLocDirector=\(eventLocDirector.text!)&eventComments=\(eventComments.text!)&eventDate=\(eventDate.text!)&eventTime=\(eventTime.text!)&eventcalid = " + savedEventId
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        })
        task.resume()
    }
    
    @IBAction func eventEditPressed(_ sender: Any) {
        allTextFieldsEnabled()
        self.editViewEvent.backgroundColor = UIColor.green
        self.eventEdit.backgroundColor = UIColor.green
        self.eventInfoSave.backgroundColor = UIColor.green
        self.eventInfoSave.isHidden = false
        
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
    
    
    @IBAction func addEvent(_ sender: UIButton) {
        let eventStore = EKEventStore()
        let startDate = "\(self.eventDate.text!) \(String(describing: self.eventTime.text!))"
        //string to date
        let dateformatter = DateFormatter()
        //dateformatter.locale
        dateformatter.dateFormat = "MM/dd/yy h:mm a"
        let caldate = dateformatter.date(from: startDate)        //done
        let endDate = caldate?.addingTimeInterval(60 * 60) // One hour
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(eventStore, title: "Dove release for \(self.eventName.text!)", startDate: caldate!, endDate: endDate!)
            })
        } else {
            createEvent(eventStore, title: "Dove release for \(self.eventName.text!)", startDate: caldate!, endDate: endDate!)
        }
    }
    
    
    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }
    
    
}

