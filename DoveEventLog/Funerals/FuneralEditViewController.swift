//
//  FuneralEditViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 7/28/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit

class FuneralEditViewController: UIViewController {

    @IBOutlet var editViewFun: UIView!
    var findFuneralKey: String!
    var find: String!
    var resultSet = NSArray()
    var relhold: String!
    var veninout: String!
    var dbInfo: NSDictionary!
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
    @IBOutlet var funeralEdit: UIButton!
    @IBOutlet var funeralSave: UIButton!
    @IBOutlet var reSchedFun: UIButtonX!
    var values:NSArray = []
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        funeralSave.isHidden = true
        reSchedFun.isHidden = true
        let url = URL(string: "http://davestucky.com/funeralEditGet.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let funeralkey = row["funeralKey"] as? String
            let longname = funeralkey
            print(funeralkey!)
            print(row["decFName"] as Any)
            if longname == findFuneralKey{
                self.deceaseFName.text = row["decFName"] as? String
                self.deceaseLName.text = row["decLName"] as? String
                self.funName.text = row["funeralHome"] as? String
                self.funHomeAddress.text = row["funeralAddress"] as? String
                self.funHomeCity.text = row["funeralCity"] as? String
                self.funHomeState.text = row["funeralState"] as? String
                self.cemeName.text = row["cemeteryName"] as? String
                self.cemeAddress.text = row["cemeteryAddress"] as? String
                self.cemeCity.text  = row["cemeteryCity"] as? String
                self.cemeState.text  = row["cemeteryState"] as? String
                self.funeralDate.text = row["funeralDate"] as? String
                self.funeralDirector.text = row["furneralDirector"] as? String
                self.funeralTime.text = row["funeralTime"] as? String
                self.funeralComments.text = row["Notes"] as? String
                
            }
            self.funeralSave.backgroundColor = UIColor.red
            allTextFieldsDisabled()
        }
}
 
    @IBAction func FuneralSavePressed(_ sender: Any) {
        
        let url = URL(string: "http://davestucky.com/funeralEdit.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        print (request.httpMethod as Any)
        
        let postString = "task=funeral&funeralKey=\(findFuneralKey!)&decFName=\(deceaseFName.text!)&decLName=\(deceaseLName.text!)&funHome=\(funName.text!)&funAddress=\(funHomeAddress.text!)&funCity=\(funHomeCity.text!)&funState=\(funHomeState.text!)&funDirector=\(funeralDirector.text!)&cemName=\(cemeName.text!)&cemAddress=\(cemeAddress.text!)&cemeCity=\(cemeCity.text!)&cemeState=\(cemeState.text!)&funeralComments=\(funeralComments.text!)&fundate=\(funeralDate.text!)&funtime=\(funeralTime.text!)"
        
        print(postString)
        
        request.httpBody = postString.data(using: String.Encoding.utf8 )
        
        print (request.httpBody as Any)
        
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

        allTextFieldsDisabled()
        self.funeralSave.backgroundColor = UIColor.green
        self.funeralEdit.backgroundColor = UIColor.red
        
    }
    
    
    @IBAction func funeralEditPressed(_ sender: Any) {
        allTextFieldsEnabled()
        self.editViewFun.backgroundColor = UIColor.green
        self.funeralEdit.backgroundColor = UIColor.green
        self.funeralSave.isHidden = false
        
    }
    
    //MARK Disable All Textfields   :
    func allTextFieldsDisabled(){
        self.deceaseFName.isUserInteractionEnabled = false
        self.deceaseLName.isUserInteractionEnabled = false
        self.funName.isUserInteractionEnabled = false
        self.funHomeAddress.isUserInteractionEnabled = false
        self.funHomeCity.isUserInteractionEnabled = false
        self.funHomeState.isUserInteractionEnabled = false
        self.cemeName.isUserInteractionEnabled = false
        self.cemeAddress.isUserInteractionEnabled = false
        self.cemeCity.isUserInteractionEnabled = false
        self.cemeState.isUserInteractionEnabled = false
        self.funeralDate.isUserInteractionEnabled = false
        self.funeralDirector.isUserInteractionEnabled = false
        self.funeralTime.isUserInteractionEnabled = false
        self.funeralComments.isUserInteractionEnabled = false
    }
    
    //MARK Disable All Textfields   :
    func allTextFieldsEnabled(){
        self.deceaseFName.isUserInteractionEnabled = true
        self.deceaseLName.isUserInteractionEnabled = true
        self.funName.isUserInteractionEnabled = true
        self.funHomeAddress.isUserInteractionEnabled = true
        self.funHomeCity.isUserInteractionEnabled = true
        self.funHomeState.isUserInteractionEnabled = true
        self.cemeName.isUserInteractionEnabled = true
        self.cemeAddress.isUserInteractionEnabled = true
        self.cemeCity.isUserInteractionEnabled = true
        self.cemeState.isUserInteractionEnabled = true
        self.funeralDate.isUserInteractionEnabled = true
        self.funeralDirector.isUserInteractionEnabled = true
        self.funeralTime.isUserInteractionEnabled = true
        self.funeralComments.isUserInteractionEnabled = true
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
    

}
