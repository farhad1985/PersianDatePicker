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
        }
    }
    @IBAction func didTapReset(_ sender: Any) {
        persianDatePickerView.currectDatePicker()
    }
}

