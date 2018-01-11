//
//  WUADCustomCellAll.swift
//  WUAD Wedding App
//
//  Created by Dave Stucky on 7/20/16.
//  Copyright © 2016 Dave Stuckenschneider. All rights reserved.
//

import Foundation
import UIKit

class WUADCustomCellAll: UITableViewCell {
    
    @IBOutlet var bandNumber:UILabel?
    @IBOutlet var bandPre:UILabel?
    @IBOutlet var bandyear:UILabel?
    @IBOutlet var bandInven:UISwitch?
    @IBOutlet var lastInven:UISwitch?
    
    
    @IBAction func bandInvenPressed(_ sender: UIButton)
    {
        if (bandInven?.isOn)!
        {
           let finder = bandNumber?.text
            
            let url = URL(string: "http://davestucky.com/birdworks.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let postString = "task=updateInven&band=\(finder!)&newinven=1"
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
            
        }else{
            let finder = bandNumber?.text
            let url = URL(string: "http://davestucky.com/birdworks.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let postString = "task=updateInven&band=\(finder!)&newinven=0"
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
    
    }
    
}

