//
//  ViewController.swift
//  Example
//
//  Created by Farhad on 11/21/17.
//  Copyright © 2017 Farhad. All rights reserved.
//
// Sample Code

import UIKit
import PersianDatePicker

class ViewController: UIViewController {

    @IBOutlet weak var persianDatePickerView: PersianDatePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        persianDatePickerView.onChange = {(year, month, day) in
            print("\(year)/\(month)/\(day)")
            print(self.persianDatePickerView.getGregorianDate()!)
            print(self.persianDatePickerView.getPersianDate()!)
            print("next day : \(self.persianDatePickerView.nextDay(by: self.persianDatePickerView.getPersianDate()!))")
        }
        
    }
    @IBAction func didTapReset(_ sender: Any) {
        persianDatePickerView.gotoCurrentDate()
    }
}

