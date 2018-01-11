//
//  EventLandViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 8/27/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit

class EventLandViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var values = [EventKey]()
    @IBOutlet var eventPickerText: UITextField!
    @IBOutlet var eventAddress: UITextField!
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewDidLoad()
        let eventPicker = UIPickerView()
        eventPicker.delegate = self
        eventPickerText.inputView = eventPicker
        getEventKeys()
    }
    
    func getEventKeys()
    {
        let url = URL(string: "http://davestucky.com/eventService.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("didn't work, \(String(describing: error))")
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    // todo
                }
            } else {
                do {
                    self.values = try JSONDecoder().decode([EventKey].self, from: data!)
                    print("\(self.values)")
                }catch {
                    print("JSON Error")
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                        // todo
                    }
                }
            }
            }.resume()
    }
    
    
    func numberOfComponents(in eventPicker: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ eventPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].eventkey
        
    }
    
    func pickerView(_ bridePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventPickerText.text = values[row].eventkey
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editEventInfo"){
            
            let destinationVC : EventInfoEditViewController  = segue.destination as! EventInfoEditViewController
            destinationVC.findEventKey = eventPickerText.text!
            self.eventPickerText.text = ""
            
        }
        
        /* if (segue.identifier == "mapVenue"){
         let destinationVC : venueMapViewController  = segue.destination as! venueMapViewController
         destinationVC.locationVenue = venAddress.text!
         //destinationVC.venueName = venue.text!
         }*/
        
        
        
    }
    
}
