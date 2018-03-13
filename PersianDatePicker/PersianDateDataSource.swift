//
//  PersianDatePresenter.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

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
		let targetDayComponents = DateComponents(calendar: cal, year: year,
												 month: month, day: 1)
		guard let targetDay = cal.date(from: targetDayComponents) else { return [] }
		guard let range = cal.range(of: .day, in: .month, for: targetDay) else { return [] }
		
		return [Int](range.lowerBound..<range.upperBound)
	}
	
	func todayCompononents() -> (year: Int, month: Int, day: Int) {
		let date = Date()
		let comps = cal.dateComponents([.year, .month, .day], from: date)
		return (year: comps.year!, month: comps.month!, day: comps.day!)
	}    
}
