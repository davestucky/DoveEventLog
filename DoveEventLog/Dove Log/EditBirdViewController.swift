//
//  EditBirdViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/15/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class EditBirdViewController: UIViewController {

    var stuff  = NSMutableArray()
    var findBand: String! = ""
    var editband_source: String!
    @IBOutlet var editView: UIView!
    var bandNoEdit: String!
    @IBOutlet var editbirdsource: UITextField!
    @IBOutlet var editBirdDOB: UITextField!
    @IBOutlet var editBirdSex: UITextField!
    var editBandYear: String!
    var editBandPrefix: String!
    @IBOutlet var editBandNumber: UITextField!
    @IBOutlet var editBirthHenBand: UITextField!
    @IBOutlet var editBirthCockBand: UITextField!
    @IBOutlet var editBirdClassBand: UITextField!
    @IBOutlet var editBandInfo: UILabel!
    let datePicker = UIDatePicker()
    
    var values:NSArray = []
    var valuesbc:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePickerMode.date
        
        getBirdEssentials()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "birdcomments"{
            let destinationVC : BirdCommentViewController  = segue.destination as! BirdCommentViewController
            destinationVC.findBand = findBand
            destinationVC.editBandPrefix = editBandPrefix
            destinationVC.editBandYear = editBandYear
        }

    }
    
    
    func getBirdEssentials(){
        let url = URL(string: "http://davestucky.com/birdeditget.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let birdGet = row["band_no"] as? String
            //let longname = findBand
            if birdGet == findBand{
                editBandYear = row["band_year"] as? String
                editband_source = row["band_source"] as? String
                editBandPrefix = row["band_suffix"] as? String
                self.editbirdsource.text = row["bird_source"] as? String
                self.editBirdSex.text = row["sex"] as? String
                self.editBirdDOB.text = row["dob"] as? String
                self.editBirthHenBand.text = row["bird_hen"] as? String
                self.editBirthCockBand.text = row["bird_cock"] as? String
                self.editBirdClassBand.text = row["class_band"] as? String
                editBandInfo.text = editBandPrefix + " - " + findBand + " - " + editBandYear
            }
            
        }
        
    }
    
    @IBAction func saveEditPressed(_ sender: AnyObject) {
        //hack
        let url = URL(string: "http://davestucky.com/birdworks.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=editbirdupdate&birdsrc=\(editbirdsource.text!)&sex=\(editBirdSex.text!)&birddob=\(editBirdDOB.text!)&mom=\(editBirthHenBand.text!)&dad=\(editBirthCockBand.text!)&class=\(editBirdClassBand.text!)&band=\(findBand!)"
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
    
    @IBAction func hatchDateSelected(_ sender: Any) {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
        editBirdDOB.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(EditBirdViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        
    }
    
        
        
    @objc func datePickerValueChanged(sender: UIDatePicker) {
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.medium
            
            dateFormatter.timeStyle = DateFormatter.Style.none
            
            editBirdDOB.text = dateFormatter.string(from: sender.date)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

        
    }



