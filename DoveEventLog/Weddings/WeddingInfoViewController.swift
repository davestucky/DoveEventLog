//
//  WeddingInfoViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 9/30/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import EventKit


class WeddingInfoViewController: UIViewController  {
    
    var wedBrideKey: String?
    @IBOutlet var bfname: UITextField!
    @IBOutlet var blname: UITextField!
    @IBOutlet var baddress: UITextField!
    @IBOutlet var bcity: UITextField!
    @IBOutlet var bstate: UITextField!
    @IBOutlet var bzip: UITextField!
    @IBOutlet var bphone: UITextField!
    @IBOutlet var bemail: UITextField!
    @IBOutlet var bmom: UITextField!
    @IBOutlet var bdad: UITextField!
    @IBOutlet var gfname: UITextField!
    @IBOutlet var glname: UITextField!
    @IBOutlet var gmom: UITextField!
    @IBOutlet var gdad: UITextField!
    @IBOutlet var weddate: UITextField!
    @IBOutlet var wedtime: UITextField!
    @IBOutlet var wedPhotoName: UITextField!
    @IBOutlet var wedPhotoAddress: UITextField!
    @IBOutlet var wedPhotoCity: UITextField!
    @IBOutlet var wedPhotoPhone: UITextField!
    @IBOutlet var wedPhotoEmail: UITextField!
    @IBOutlet var brideSave: UIButton!
    @IBOutlet var groomSave: UIButton!
    @IBOutlet var photogContacted: UISwitch!
    var savedEventId : String = ""    
    var objects = NSMutableArray()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bfname.becomeFirstResponder()
        
    }
    
    
    @IBAction func brideSavePressed(_ sender: UIButton?) {
        //hack
        let url = URL(string: "http://davestucky.com/weddingAdd.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "task=bride&wedBrideKey=\(bfname.text! + blname.text!)&brideFName=\(bfname.text!)&brideLName=\(blname.text!)&brideAddress=\(baddress.text!)&brideCity=\(bcity.text!)&brideState=\(bstate.text!)&brideZip=\(bzip.text!)&bridePhone=\(bphone.text!)&brideEmail=\(bemail.text!)&brideMom=\(bmom.text!)&brideDad=\(bdad.text!)&weddate=\(weddate.text!)&wedtime=\(wedtime.text!)"
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
    
    @IBAction func groomSavePressed(_ sender: UIButton?) {
        //hack
        let url = URL(string: "http://davestucky.com/weddingAdd.php" )
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=groom&groomFName=\(gfname.text!)&groomLName=\(glname.text!)&groomMom=\(gmom.text!)&groomDad=\(gdad.text!)&wedBrideKey=\(bfname.text! + blname.text!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editDatePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = false
            popup.onSave = { (data) in
                self.weddate.text = data
            }
        }
        
        if (segue.identifier == "editTimePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = true
            popup.onSave = { (Data) in
                self.wedtime.text = Data
            }
        }
    }
    
    
    @IBAction func addEvent(_ sender: UIButton) {
        let eventStore = EKEventStore()
        
        let startDate = "\(self.weddate.text!) \(String(describing: self.wedtime.text!))"
        
        //string to date
        let dateformatter = DateFormatter()
        //dateformatter.locale
        dateformatter.dateFormat = "MM/dd/yy h:mm a"
        let caldate = dateformatter.date(from: startDate)        //done
        let endDate = caldate?.addingTimeInterval(60 * 60) // One hour
        
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(eventStore, title: "Weddinhg for \(self.bfname!) \(self.blname!)", startDate: caldate!, endDate: endDate!)
            })
        } else {
            createEvent(eventStore, title: "Funeral for \(self.bfname.text!) \(String(describing: self.blname.text!))", startDate: caldate!, endDate: endDate!)
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
