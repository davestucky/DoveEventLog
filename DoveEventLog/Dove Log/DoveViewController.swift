//
//  DoveViewController.swift
//  MyDoveLog
//
//  Created by DaveStucky on 9/11/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation
import CoreLocation

class DoveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var audioPlayer = AVAudioPlayer()
    var values:NSArray = []
    var values1:NSArray = []
    var itemSelected: String!
    var stuff  = NSMutableArray()
    var stuff1  = NSMutableArray()
    var moveBride: String!
    var allbirdlist: String!
    
    
    @IBOutlet var companyName: UILabel!
    //@IBOutlet var lastLight: UITextField!
    @IBOutlet var hatchDate: UITableView!
    @IBOutlet var cockEggMate: UITextField!
    @IBOutlet var bandnotoedit: UITextField!
    @IBOutlet var quickComment: UITextField!
    @IBOutlet var birdLostBtn: UIButton!
    @IBOutlet var couplesWithBabies: UIButton!
    @IBOutlet var couplesWithEggs: UIButton!
    @IBOutlet var bridePicker: UIPickerView!
    @IBOutlet var allBirdPicker: UIPickerView!
    @IBOutlet var venue: UITextField!
    @IBOutlet var venAddress: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var weatherView: UIView!
    @IBOutlet var sunSetView: UIView!
    var birdlist1 = [BirdsWithEggs]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = (UserDefaults.standard.value(forKey: "coName") as? String) {
            companyName.text = name
        }
       //Begin check to see if internet is available
        getAllBirdsList()
        if Reachability.isConnectedToNetwork() == true {
            
        } else {
            createAlert(title: "No Internet Connection", message: "Make sure your device is connected to the internet.")

        }

    }

    
    //Start Fake Eggs
    @IBAction func birdGivenFakeEggs(_ sender: AnyObject) {
        
        guard bandnotoedit.text! != "" else {
            createAlert(title: "Challenge", message: "Band Number to EDIT not supplied")
            return
        }
        let date = Date() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.string(from: date)
        
        //Add 15 days to today
        let nextDay = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: 15,
            to: date,
            options: NSCalendar.Options(rawValue: 0))
        let hatchDay = dateFormatter.string(from: nextDay!)
        let url = URL(string: "http://davestucky.com/birdworks.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=fakeegg&typecomment=FakeEggs&band=\(bandnotoedit.text!)&henband=\(bandnotoedit.text!)&cockband=\(cockEggMate.text!)&date=\(dateString)&desc=Bird given FAKE EGGS&datehatch=\(hatchDay)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            //print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            if responseString == "Success"{
                // Set the sound file name & extension
                let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "dataupdatesound", ofType: "mp3")!)
                
                do {
                    // Preperation
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch _ {
                }
                
                // Play the sound
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: alertSound)
                } catch _{
                }
                
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
            
            
            print("responseString = \(responseString!)")
        }
        task.resume()
        bandnotoedit.text = ""
        
        
    }
    //End Fake Eggs
    
    //Start Quick Comments
    @IBAction func birdGivenQuickComment(_ sender: AnyObject) {
        
        guard bandnotoedit.text! != "" else {
            createAlert(title: "Challenge", message: "Band Number for Quick Comment not supplied")
            return
         }
        
        guard quickComment.text! != "" else {
            createAlert(title: "Challenge", message: "Quick Comment not supplied")
            return
                    }
        
        let date = Date() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.string(from: date)
        
        //hack
        let url = URL(string: "http://davestucky.com/birdworks.php")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=misccomment&band=\(bandnotoedit.text!)&date=\(dateString)&desc=Bird given \(String(describing: quickComment.text!))"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            //print("response = \(response)")
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            if responseString == "Success"{
                // Set the sound file name & extension
                let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "dataupdatesound", ofType: "mp3")!)
                
                do {
                    // Preperation
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch _ {
                }
                
                // Play the sound
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: alertSound)
                } catch _{
                }
                
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
            
            
            print("responseString = \(responseString!)")
        }
        task.resume()
        bandnotoedit.text = ""
        quickComment.text = ""
    }
    //End Quick Comments
    
    //Start Lay Eggs
    @IBAction func henLayEggPressed(_ sender: AnyObject) {
        
        guard (bandnotoedit.text! != "" || cockEggMate.text! != "") else {
            createAlert(title: "Challenge", message: "Band Number for Hen who laid eggs not provided")
            return

        }
        /*guard cockEggMate.text! != "" else {
            createAlert(title: "Challenge", message: "Band Number for MATE not provided")
            return
            
            
        }*/
        
        
        /***CONVERT FROM NSDate to String ****/
        let date = Date() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.string(from: date)
        
        //Add 15 days to today
        let nextDay = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: 17,
            to: date,
            options: NSCalendar.Options(rawValue: 0))
        let hatchDay = dateFormatter.string(from: nextDay!)
        
        //hack
        let url = URL(string: "http://davestucky.com/birdworks.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=egglay&henband=\(bandnotoedit.text!)&cockband=\(cockEggMate.text!)&date=\(dateString)&hatchdate=\(hatchDay)"
        print(postString)
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
        bandnotoedit.text = ""
        cockEggMate.text = ""
        
    }
    
    //End Lay Eggs
    
    //Start Bird Lost
    @IBAction func birdLostPressed(_ sender: AnyObject) {
        
        guard bandnotoedit.text! != "" else {
            createAlert(title: "Challenge", message: "Band Number for LOST BIRD not provided")
            return
        }
        
        
        let date = Date() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.string(from: date)
        //hack
        let url = URL(string: "http://davestucky.com/birdworks.php")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=birdlost&band=\(bandnotoedit.text!)&date=\(dateString)"
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
        bandnotoedit.text = ""
    }
    //End Bird Lost
    
    //Start Bird Found
    @IBAction func birdFoundPressed(_ sender: AnyObject) {
        
        guard bandnotoedit.text! != "" else {
            let alertController = UIAlertController(title: "Challenge", message: "Band Number for FOUND BIRD not provided", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        
        //hack
        let request = NSMutableURLRequest(url: URL(string: "http://davestucky.com/birdworks.php")!)
        request.httpMethod = "POST"
        let postString = "task=birdfound&band=\(bandnotoedit.text!)"
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
        bandnotoedit.text = ""
    }
    //End Bird Found
    
    
    //Start Bird Edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        
        if segue.identifier == "editBird"{
            
            guard bandnotoedit.text! != "" else {
                let alertController = UIAlertController(title: "Challenge", message: "Band Number to Edit not supplied", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            
            let destinationVC : EditBirdViewController  = segue.destination as! EditBirdViewController
            destinationVC.findBand = bandnotoedit.text
            bandnotoedit.text = ""
            
        }
        
        if segue.identifier == "comfromopenscr" {
            
            guard bandnotoedit.text! != "" else {
                let alertController = UIAlertController(title: "Challenge", message: "Band Number to Comment on not supplied", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            
            let destinationVC : BirdCommentViewController  = segue.destination as! BirdCommentViewController
            destinationVC.findBand = bandnotoedit.text
            destinationVC.logenter = "front"
            //destinationVC.editBandPrefix = editBandPrefix
            //destinationVC.editBandYear = editBandYear
        }
        
    }
    //End Bird Edit
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birdlist1.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FrontBirdEgg
        
        let item = birdlist1[(indexPath as NSIndexPath).row]
        
        cell.henBand!.text = item.henband
        cell.cockBand!.text = item.cockband
        cell.hatchDate!.text = item.hatchdate
        
        
        
        return cell
    }
    


    func getAllBirdsList(){
        let url = URL(string: "http://davestucky.com/birdworks6.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])!  {
            let eggBirds = BirdsWithEggs()
            eggBirds.henband = (row["henbandno"] as? String)!
            eggBirds.cockband = (row["cockbandno"] as? String)!
            eggBirds.hatchdate = (row["datehatch"] as? String)!
            birdlist1.append(eggBirds)
            
        }
    }

    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print ("YES")
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("NO")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}

