//
//  PersianDatePresenter.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

struct PersianDatePresenter {
    
    let cal = Cal()
    
    init() {
    }
    
    func getYears() -> [Int] {
        return cal.getYears()
    }
    
    func getMonths() -> [MonthName] {
        return cal.getMonths()
    }
    
    func getDays(month: MonthName) -> [Int] {
        switch month {
        case .farvardin, .ordibehesht, .khordad, .tir, .mordad, .shahrivar:
            return cal.getDays(lastDay: 31)
            
        case .mehr, .aban, .azar, .dey, .bahman:
            return cal.getDays(lastDay: 30)
        
        case .esfand:
            return cal.getDays(lastDay: 29)
        }
    }
}
