//
//  NewBirdViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/15/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class NewBirdViewController: UIViewController {

    @IBOutlet var addBirdSource: UITextField!
    @IBOutlet var addBirdDOB: UITextField!
    @IBOutlet var addBirdSex: UITextField!
    @IBOutlet var addBandSource: UITextField!
    @IBOutlet var addBandYear: UITextField!
    @IBOutlet var addBandPrefix: UITextField!
    @IBOutlet var addBandNumber: UITextField!
    @IBOutlet var addBirthHenBand: UITextField!
    @IBOutlet var addBirthCockBand: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        //hack
        //format date
        let url = URL(string: "http://davestucky.com/birdworks.php")
        var request = URLRequest(url:url!)
        request.httpMethod = "POST"
        let postString = "task=newbird&bandsrc=\(addBandSource.text!)&bandyr=\(addBandYear.text!)&bandpref=\(addBandPrefix.text!)&band=\(addBandNumber.text!)&birdsrc=\(addBirdSource.text!)&sex=\(addBirdSex.text!)&birddob=\(addBirdDOB.text!)&mom=\(addBirthHenBand.text!)&dad=\(addBirthCockBand.text!)"
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
    
    
    
    
}

    

