//
//  PersianDatePresenter.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import UIKit

struct PersianDateDataSource {
	//MARK: - Properties
	private let cal: Calendar
	var years: [Int]
	var persianMonths: [String]
	
	init() {
		cal = {
			var c = Calendar(identifier: .persian)
			c.locale = Locale(identifier: "fa_IR")
			return c
		}()
		
		years = Array(1300...1500)
		persianMonths = cal.monthSymbols
	}
	
	
	func daysRange(ofYear year:Int, month: Int) -> [Int] {
		let targetDayComponents = DateComponents(calendar: cal,
                                                 year: year,
												 month: month,
                                                 day: 1)
		guard let targetDay = cal.date(from: targetDayComponents) else { return [] }
		guard let range = cal.range(of: .day, in: .month, for: targetDay) else { return [] }
		
		return [Int](range.lowerBound..<range.upperBound)
	}
	
	func todayCompononents() -> (year: Int, month: Int, day: Int) {
		let date = Date()
		let comps = cal.dateComponents([.year, .month, .day], from: date)
		return (year: comps.year!, month: comps.month!, day: comps.day!)
	}
    
    func getPersianDate(year: Int, month: Int, day: Int) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")

        let persianDate = "\(year)/\(month)/\(day)"
        let date = dateFormatter.date(from: persianDate)
        return date
    }
    
    func convertToGregorian(year: Int, month: Int, day: Int) -> Date? {
        guard let persianDate = getPersianDate(year: year, month: month, day: day) else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let gregorianDateString = dateFormatter.string(from: persianDate)
        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter.date(from: gregorianDateString)
    }
    
    func nextDay(by date: Date) -> Date {
        return cal.date(byAdding: .day, value: 1, to: date)!
    }
    
    func backDay(by date: Date) -> Date {
        return cal.date(byAdding: .day, value: -1, to: date)!
    }
}
