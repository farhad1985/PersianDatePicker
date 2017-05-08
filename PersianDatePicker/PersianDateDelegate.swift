//
//  PersianDateView.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

@objc public protocol PersianDateDelegate {
    
    @objc optional func persianDate(persianDatePickerView: PersianDatePickerView, year: Int, monthName: String, day: Int)
    @objc optional func persianDate(persianDatePickerView: PersianDatePickerView, year: Int, month: Int, day: Int)

}
