//
//  FuneralInfoViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/7/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit
import EventKit

class FuneralInfoViewController: UIViewController {
    
    @IBOutlet var deceaseFName: UITextField!
    @IBOutlet var deceaseLName: UITextField!
    @IBOutlet var funName: UITextField!
    @IBOutlet var funHomeAddress: UITextField!
    @IBOutlet var funHomeCity: UITextField!
    @IBOutlet var funHomeState: UITextField!
    @IBOutlet var cemeName: UITextField!
    @IBOutlet var cemeAddress: UITextField!
    @IBOutlet var cemeCity: UITextField!
    @IBOutlet var cemeState: UITextField!
    @IBOutlet var funeralDate: UITextField!
    @IBOutlet var funeralTime: UITextField!
    @IBOutlet var funeralComments: UITextView!
    @IBOutlet var funeralDirector: UITextField!
    @IBOutlet var funeralDatePicker: UIDatePicker!
    @IBOutlet var funeralTimePicker: UIDatePicker!
    var showTimePicker = false
    var onSave: ((_ data: String)->())?
    var savedEventId : String = ""
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func funInfoSave(_ sender: AnyObject) {
        
        //hack
            let url = URL(string: "http://davestucky.com/funeralAdd.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let postString = "task=funeral&funeralKey=\(deceaseFName.text! + deceaseLName.text!)&decFName=\(deceaseFName.text!)&decLName=\(deceaseLName.text!)&funHome=\(funName.text!)&funAddress=\(funHomeAddress.text!)&funCity=\(funHomeCity.text!)&funState=\(funHomeState.text!)&funDirector=\(funeralDirector.text!)&cemName=\(cemeName.text!)&cemAddress=\(cemeAddress.text!)&cemeCity=\(cemeCity.text!)&cemeState=\(cemeState.text!)&funeralComments=\(funeralComments.text!)&fundate=\(funeralDate.text!)&funtime=\(funeralTime.text!)"
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editDatePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = false
            popup.onSave = { (data) in
                self.funeralDate.text = data
            }
        }
        
        if (segue.identifier == "editTimePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = true
            popup.onSave = { (Data) in
                self.funeralTime.text = Data
            }
        }
    }
    
//    //datepicker start
//    
//    @IBAction func funeralDateSelected(_ sender: Any) {
//        let datePicker = UIDatePicker()
//        
//        datePicker.datePickerMode = UIDatePickerMode.date
//        
//        datePicker.minimumDate = Date()
//        funeralDate.inputView = datePicker
//        
//        datePicker.addTarget(self, action: #selector(FuneralInfoViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
//        
//        
//    }
//    
//    @objc func datePickerValueChanged(sender: UIDatePicker) {
//        
//        let dateFormatter = DateFormatter()
//        
//        dateFormatter.dateStyle = DateFormatter.Style.medium
//        
//        dateFormatter.timeStyle = DateFormatter.Style.none
//        
//        funeralDate.text = dateFormatter.string(from: sender.date)
//    }
    
//    @IBAction func funeralTimeSelected(_ sender: UITextField) {
//        let datePicker = UIDatePicker()
//        
//        datePicker.datePickerMode = UIDatePickerMode.time
//        datePicker.minuteInterval = 15
//        funeralTime.inputView = datePicker
//        
//        datePicker.addTarget(self, action: #selector(FuneralInfoViewController.timePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
//        
//    }
//    
//    
//    @objc func timePickerValueChanged(sender: UIDatePicker) {
//        
//        let timeFormatter = DateFormatter()
//        
//        timeFormatter.dateStyle = DateFormatter.Style.none
//        
//        timeFormatter.timeStyle = DateFormatter.Style.short
//        
//        funeralTime.text = timeFormatter.string(from: sender.date)
//    }
//    
//    @IBAction func addEvent(_ sender: UIButton) {
//        let eventStore = EKEventStore()
//        
//        let startDate = "\(self.funeralDate.text!) \(String(describing: self.funeralTime.text!))"
//        
//        //string to date
//        let dateformatter = DateFormatter()
//        //dateformatter.locale
//        dateformatter.dateFormat = "MM/dd/yy h:mm a"
//        let caldate = dateformatter.date(from: startDate)        //done
//        let endDate = caldate?.addingTimeInterval(60 * 60) // One hour
//        
//        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
//            eventStore.requestAccess(to: .event, completion: {
//                granted, error in
//                self.createEvent(eventStore, title: "Funeral for \(self.deceaseFName!) \(self.deceaseLName!)", startDate: caldate!, endDate: endDate!)
//            })
//        } else {
//            createEvent(eventStore, title: "Funeral for \(self.deceaseFName.text!) \(String(describing: self.deceaseLName.text!))", startDate: caldate!, endDate: endDate!)
//        }
//    }
//
//    
//    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
//        let event = EKEvent(eventStore: eventStore)
//        
//        event.title = title
//        event.startDate = startDate
//        event.endDate = endDate
//        event.calendar = eventStore.defaultCalendarForNewEvents
//        do {
//            try eventStore.save(event, span: .thisEvent)
//            savedEventId = event.eventIdentifier
//        } catch {
//            print("Bad things happened")
//        }
//    }


    }
