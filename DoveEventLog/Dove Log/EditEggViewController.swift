//
//  EditEggViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 12/13/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class EditEggViewController: UIViewController {

    @IBOutlet var updateHenBand: UITextField!
    @IBOutlet var updateCockBand: UITextField!
    @IBOutlet var updateHatchDate: UITextField!
    @IBOutlet var updateIDNumber: UITextField!
    var henbandlabel: String = ""
    var cockbandlabel: String = ""
    var datehatchlabel: String = ""
    var IDNumber = 0
    //var recordNum = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         if henbandlabel != ""{
        updateHenBand!.text = henbandlabel
        }
        if cockbandlabel != "" {
        updateCockBand!.text = cockbandlabel
        }
        updateHatchDate!.text = datehatchlabel
        //updateIDNumber.text = IDNumber
    }

    
    @IBAction func updateCouplesEggsPressed(_ sender: Any)
    {
        let url = URL(string: "http://davestucky.com/birdworks.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=realeggsupdate&henband=\(updateHenBand.text!)&cockband=\(updateCockBand.text!)&recordID=\(IDNumber)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) {
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
