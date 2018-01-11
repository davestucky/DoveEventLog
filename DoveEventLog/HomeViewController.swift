//
//  HomeViewController.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 10/23/17.
//  Copyright © 2017 Dave Stucky. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet var companyName: UITextField!
    @IBOutlet var loftLong: UITextField!
    @IBOutlet var loftLat: UITextField!
    @IBOutlet var timeZone: UITextField!
    @IBOutlet var defaultsScreen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveDefaultsPressed(_ sender: UIButton) {
        UserDefaults.standard.set(companyName.text, forKey: "coName")
        UserDefaults.standard.set(loftLong.text, forKey: "loftLong")
        UserDefaults.standard.set(loftLat.text, forKey: "loftLat")
        UserDefaults.standard.set(timeZone.text, forKey: "timeZone")
        performSegue(withIdentifier: "toMainSegue" , sender: self)
    }
    
    
}

