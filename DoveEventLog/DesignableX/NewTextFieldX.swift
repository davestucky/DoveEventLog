//
//  NewTextFieldX.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 3/2/18.
//  Copyright © 2018 Dave Stucky. All rights reserved.
//

import Foundation
import UIKit


class MyCustomTextField : UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.blue
        self.tintColor = UIColor.white
        self.textColor = UIColor.white
    }
    
    
}
