//
//  WeddingVenueInfoViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/1/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import Foundation
import UIKit


class WeddingVenueInfoViewController: UIViewController {
    
    @IBOutlet var vname: UITextField!
    @IBOutlet var vaddress: UITextField!
    @IBOutlet var vcity: UITextField!
    @IBOutlet var vstate: UITextField!
    @IBOutlet var vzip: UITextField!
    @IBOutlet var vphone: UITextField!
    @IBOutlet var vemail: UITextField!
    @IBOutlet var vinout: UITextField!
    @IBOutlet var wedMainColor: UITextField!
    @IBOutlet var wedSecColor: UITextField!
    @IBOutlet var wedTertColor: UITextField!
    @IBOutlet var wedNumberDoves: UITextField!
    @IBOutlet var wedReleaseHold: UITextField!
    @IBOutlet var wedPhotoName: UITextField!
    @IBOutlet var wedPhotoAddress: UITextField!
    @IBOutlet var wedPhotoCity: UITextField!
    @IBOutlet var wedPhotoPhone: UITextField!
    @IBOutlet var wedPhotoEmail: UITextField!
    @IBOutlet var wedSpecInst: UITextView!
    @IBOutlet var venueSave: UIButton!
    var brideKey: String = ""
 
    
    @IBAction func venueSavePressed(_ sender: UIButton!) {
        //hack
        let url = URL(string: "http://davestucky.com/weddingAdd.php")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "task=venue&wedBrideKey=\(brideKey)&wedVenue=\(vname.text!)&wedVenueAddress=\(vaddress.text!)&wedVenueCity=\(vcity.text!)&wedVenueState=\(vstate.text!)&wedVenueZip=\(vzip.text!)&webVenuePhone=\(vphone.text!)&wedVenueEmail=\(vemail.text!)&wedVenueInOut=\(vinout.text!)&wedMainColor=\(wedMainColor.text!)&wedSpecialInstructions=\(wedSpecInst.text!)"
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
