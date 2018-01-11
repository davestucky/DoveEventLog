//
//  WeddingLandViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 4/25/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit


class WeddingLandViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
     var values = [WeddingKey]()
    @IBOutlet var weddingPickerText: UITextField!
    @IBOutlet var venAddress: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let bridePicker = UIPickerView()
        bridePicker.delegate = self
        weddingPickerText.inputView = bridePicker
        getBrideKeys()
        
}

    func getBrideKeys()
    {
        let url = URL(string: "http://davestucky.com/service.php?task=getkeys")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("didn't work, \(String(describing: error))")
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    // todo
                }
            } else {
                do {
                    self.values = try JSONDecoder().decode([WeddingKey].self, from: data!)
                }catch {
                    print("JSON Error")
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                        // todo
                    }
                }
            }
            }.resume()
    }
    func numberOfComponents(in bridePicker: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ bridePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].wedBrideKey
        
        }
    
    func pickerView(_ bridePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weddingPickerText.text = values[row].wedBrideKey
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditWedInfo"){
            
            let destinationVC : WeddingEditViewController  = segue.destination as! WeddingEditViewController
            destinationVC.findWedBrideKey = weddingPickerText.text!
            
        }
        
        if (segue.identifier == "mapVenue"){
            let destinationVC : venueMapViewController  = segue.destination as! venueMapViewController
            destinationVC.locationVenue = venAddress.text!
            //destinationVC.venueName = venue.text!
        }

    }

}
