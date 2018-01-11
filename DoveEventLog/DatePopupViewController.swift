//
// DatePopupViewController.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 12/4/17.
//  Copyright © 2017 Dave Stucky. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    var showTimePicker: Bool = false
    var onSave: (( _ data: String) -> ())?
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: datePicker.date)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: datePicker.date)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showTimePicker {
            titleLabel.text = "Select Time"
            datePicker.datePickerMode = .time
            saveButton.setTitle("Save Time", for: .normal)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func saveDate_TouchUpInside(_ sender: UIButton) {
        
        if showTimePicker {
            onSave?(formattedTime)
        } else {
            onSave?(formattedDate)
        }
        
        onSave?(formattedDate)
        dismiss(animated: true)
    }
    
    }
    


