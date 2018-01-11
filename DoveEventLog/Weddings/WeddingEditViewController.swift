//
// WeddingEditViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/10/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class WeddingEditViewController: UIViewController {

    var findWedBrideKey: String!
    var find: String!
    var resultSet = NSArray()
    var relhold: String!
    var veninout: String!
    var dbInfo: NSDictionary!
    
    @IBOutlet weak var wedTime: UITextField!
    @IBOutlet weak var wedDate: UITextField!
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
    @IBOutlet var wedPhotoContact: UISwitch!
    @IBOutlet var wedPhotoName: UITextField!
    @IBOutlet var wedPhotoAddress: UITextField!
    @IBOutlet var wedPhotoCity: UITextField!
    @IBOutlet var wedPhotoPhone: UITextField!
    @IBOutlet var wedPhotoEmail: UITextField!
    var values:NSArray = []
    var valuesg:NSArray = []
    var valuesp:NSArray = []
    var valuesv:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://davestucky.com/weddingEdit.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let bridekey = row["wedBrideKey"] as? String
            let longname = bridekey
            print(bridekey!)
            if longname == findWedBrideKey{
                self.bfname.text = row["brideFName"] as? String
                self.blname.text = row["brideLName"] as? String
                self.baddress.text = row["brideAddress"] as? String
                self.bcity.text = row["brideCity"] as? String
                self.bstate.text = row["brideState"] as? String
                self.bzip.text = row["brideZip"] as? String
                self.bphone.text = row["bridePhone"] as? String
                self.bemail.text = row["brideEmail"] as? String
                self.bmom.text  = row["brideMom"] as? String
                self.bdad.text  = row["brideDad"] as? String
                
            }
            
        }
        let urlg = URL(string: "http://davestucky.com/groomEdit.php")
        let datag = try? Data(contentsOf: urlg!)
        valuesg = try! JSONSerialization.jsonObject(with: datag!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (valuesg  as? [[String:Any]])! {
            
            let bridekey = row["wedBrideKey"] as? String
            let longname = bridekey
            if longname == findWedBrideKey{
                self.gfname.text = row["groomFName"] as? String
                self.glname.text = row["groomLName"] as? String
                self.gmom.text  = row["groomMom"] as? String
                self.gdad.text  = row["groomDad"] as? String
                
            }
            
        }
        let urlp = URL(string: "http://davestucky.com/photoEdit.php")
        let datap = try? Data(contentsOf: urlp!)
        valuesp = try! JSONSerialization.jsonObject(with: datap!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (valuesp as? [[String:Any]])!{
            
            let bridekey = row["wedBrideKey"] as? String
            let longname = bridekey
            
            if longname == findWedBrideKey{
                self.wedPhotoName.text = row["wedPhotographer"] as? String
                self.wedPhotoAddress.text = row["wedPhotographerAddress"] as? String
                self.wedPhotoCity.text  = row["wedPhotographerCity"] as? String
                self.wedPhotoPhone.text  = row["wedPhotographerPhone"] as? String
                self.wedPhotoEmail.text  = row["wedPhotographerEmail"] as? String
            }
        }
        }
    
    @IBAction func editBrideSavePressed(_ sender: UIButton!) {
        //hack
        let url = URL(string: "http://davestucky.com/weddingAdd.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=brideedit&wedBrideKey=\(bfname.text! + blname.text!)&brideFName=\(bfname.text!)&brideLName=\(blname.text!)&brideAddress=\(baddress.text!)&brideCity=\(bcity.text!)&brideState=\(bstate.text!)&brideZip=\(bzip.text!)&bridePhone=\(bphone.text!)&brideEmail=\(bemail.text!)&brideMom=\(bmom.text!)&brideDad=\(bdad.text!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) {
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
    
    @IBAction func editGroomSavePressed(_ sender: UIButton!) {
        //hack
        let url = URL(string: "http://davestucky.com/weddingAdd.php")
        var request = URLRequest(url:url!)
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
    
    @IBAction func editPhotoSavePressed(_ sender: UIButton!) {
        //hack
        var request = URLRequest(url: URL(string: "http://davestucky.com/weddingAdd.php")!)
        request.httpMethod = "POST"
        let postString = "task=photo&wedPhotographer=\(wedPhotoName.text!)&wedPhotographerAddress=\(wedPhotoAddress.text!)&wedPhotographerCity=\(wedPhotoCity.text!)&wedPhotographerPhone=\(wedPhotoPhone.text!)&wedPhotographerEmail='\(wedPhotoEmail.text!)'&wedBrideKey=\(bfname.text! + blname.text!)"
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
                self.wedDate.text = data
            }
        }
        
        if (segue.identifier == "editTimePopUp"){
            let popup =  segue.destination as! DatePopupViewController
            popup.showTimePicker = true
            popup.onSave = { (Data) in
                self.wedTime.text = Data
            }
        }
        
        if (segue.identifier == "editVenue"){
            
            let destinationVC : WeddingEditVenueViewController  = segue.destination as! WeddingEditVenueViewController
            destinationVC.getWedBrideKey = findWedBrideKey
            
        }
        
        /*if (segue.identifier == "mapVenue"){
            let destinationVC : venueMapViewController  = segue.destination as! venueMapViewController
            destinationVC.locationVenue = venAddress.text!
            //destinationVC.venueName = venue.text!
        }*/
        
    }
    
}
