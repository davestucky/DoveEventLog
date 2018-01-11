//
//  FuneralLandViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 7/27/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit


class FuneralLandViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var values = [FuneralKey]()
    @IBOutlet var funeralPickerText: UITextField!
    @IBOutlet var cemetaryAddress: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let funeralPicker = UIPickerView()
        funeralPicker.delegate = self
        funeralPickerText.inputView = funeralPicker
        getFuneralKeys()
    }
    
    
    func getFuneralKeys()
    {
        let url = URL(string: "http://davestucky.com/funeralService.php?task=getkeys")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("didn't work, \(String(describing: error))")
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    // todo
                }
            } else {
                do {
                    self.values = try JSONDecoder().decode([FuneralKey].self, from: data!)
                    
                }catch {
                    print("JSON Error")
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                        // todo
                    }
                }
            }
            }.resume()
    }
    
    func numberOfComponents(in funeralPicker: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ funeralPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].funeralKey
        
    }
    
    func pickerView(_ funeralPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        funeralPickerText.text = values[row].funeralKey
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editFuneralInfo"){
            let destinationVC : FuneralEditViewController  = segue.destination as! FuneralEditViewController
            destinationVC.findFuneralKey = funeralPickerText.text!
            self.funeralPickerText.text = ""

            
        }
        
       if (segue.identifier == "addNewFurneral"){
        _ = [String].self
            self.funeralPickerText.text = ""
        }
        
        
        
    }
    
}
