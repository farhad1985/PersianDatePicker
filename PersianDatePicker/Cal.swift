//
//  Common.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

enum MonthName: String {
    case farvardin = "فروردین"
    case ordibehesht = "اردیبهشت"
    case khordad = "خرداد"
    case tir = "تیر"
    case mordad = "مرداد"
    case shahrivar = "شهریور"
    case mehr = "مهر"
    case aban = "آبان"
    case azar = "آذر"
    case dey = "دی"
    case bahman = "بهمن"
    case esfand = "اسفند"
}

struct Cal {
    
    func getMonths() -> [MonthName] {
        return [
            .farvardin,
            .ordibehesht,
            .khordad,
            .tir,
            .mordad,
            .shahrivar,
            .mehr,
            .aban,
            .azar,
            .dey,
            .bahman,
            .esfand
        ]
    }
    
    func getYears() -> [Int] {
        var y: [Int] = []
        for i in 1300...1500 {
            y += [i]
        }
        
        return y
    }
    
    func getDays(lastDay: Int) -> [Int] {
        var days: [Int] = []
        for i in 1...lastDay {
            days += [i]
        }
        
        return days
    }
}





