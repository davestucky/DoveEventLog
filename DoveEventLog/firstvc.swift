//
//  firstvc.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 10/25/17.
//  Copyright © 2017 Dave Stucky. All rights reserved.
//

import UIKit

class firstvc: UIViewController {

@IBOutlet var companyName: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        if let name = (UserDefaults.standard.value(forKey: "coName") as? String) {
            companyName.text = name
        } 
    }
    
}

