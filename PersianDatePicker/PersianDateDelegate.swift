//
//  PersianDateView.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

public protocol PersianDateDelegate {
    
    func persianDate(persianPickerView: PersianPickerView, year: Int, month: String, day: Int)
}
