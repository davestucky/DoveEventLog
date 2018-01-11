//
//  WeddingEditVenueViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/10/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class WeddingEditVenueViewController: UIViewController {
    
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
    @IBOutlet var wedSpecInst: UITextView!
    @IBOutlet var weddingDate: UITextField!
    @IBOutlet var wedTime: UITextField!
    
    var valuesv: NSArray = []
    var getWedBrideKey: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    

    let urlv = URL(string: "http://davestucky.com/venueEdit.php")
    let datav = try? Data(contentsOf: urlv!)
    valuesv = try! JSONSerialization.jsonObject(with: datav!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
    for row in (valuesv as? [[String:Any]])! {
    
    let bridekey = row["wedBrideKey"] as? String
    let longname = bridekey
    
    if longname == getWedBrideKey{
    self.vname.text = row["wedVenue"] as? String
    self.vinout.text = row["wedVenueInOut"] as? String
    self.vaddress.text = row["wedVenueAddress"] as? String
    self.vcity.text = row["wedVenueCity"] as? String
    self.vstate.text = row["wedVenueState"] as? String
    self.vzip.text = row["wedVenueZip"] as? String
    self.vphone.text = row["wedVenuePhone"] as? String
    self.vemail.text = row["wedVenueEmail"] as? String
    self.wedMainColor.text  = row["wedMainColor"] as? String
    self.wedSecColor.text  = row["wedSecColor"] as? String
    self.wedTertColor.text  = row["wedTerColor"] as? String
    self.wedNumberDoves.text  = row["wedNumDoves"] as? String
    self.wedReleaseHold.text  = row["wedHoldRelease"] as? String
    self.wedSpecInst.text  = row["wedSpecialInstructions"] as? String
    }
}
}
    
    @IBAction func venueSavePressed(_ sender: AnyObject) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

    
}
