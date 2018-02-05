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
	var years = Array(1300...1500)
	var persianMonths: [String] = {
		var cal = Calendar(identifier: .persian)
		cal.locale = Locale(identifier: "fa_IR")
		return cal.monthSymbols
	}()
	
	
	func daysRange(ofYear year:Int, month: Int) -> [Int] {
		let cal = Calendar(identifier: .persian)
		let targetDayComponents = DateComponents(calendar: cal, year: year, month: month, day: 1)
		guard let targetDay = cal.date(from: targetDayComponents) else { return [] }
		guard let range = cal.range(of: .day, in: .month, for: targetDay) else { return [] }
		
		return [Int](range.lowerBound..<range.upperBound)
	}
	
	func getDateToday() -> (year: Int, month: Int, day: Int) {
		let date = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy/MM/dd"
		dateFormatter.calendar = Calendar(identifier: .persian)
		let stringDate = dateFormatter.string(from: date)
		let spliteDate = stringDate.components(separatedBy: "/")
		return (year: Int(spliteDate[0])!, month: Int(spliteDate[1])!, day: Int(spliteDate[2])!)
	}
}
