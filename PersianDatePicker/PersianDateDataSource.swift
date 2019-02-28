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
    
    func myDateCompononents(date: Date) -> (year: Int, month: Int, day: Int) {
        let call = Calendar(identifier: .gregorian)
        let comps = call.dateComponents([.year, .month, .day], from: date)
        return (year: comps.year!, month: comps.month!, day: comps.day!)
    }
    
    func getPersianDate(year: Int, month: Int, day: Int) -> String? {
        return "\(year)/\(month)/\(day)"
    }
    
    func convertToGregorian(year: Int, month: Int, day: Int) -> Date? {
        guard let persianDate = getPersianDate(year: year, month: month, day: day) else {return nil}
        let persianFormatter = DateFormatter()
        persianFormatter.dateFormat = "yyyy/MM/dd"
        persianFormatter.calendar = Calendar(identifier: .persian)
        let pdate = persianFormatter.date(from: persianDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let gregorianDateString = dateFormatter.string(from: pdate!)
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter.date(from: gregorianDateString)
    }

    func convertToPersian(date: Date) -> (year: Int, month: Int, day: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.calendar = Calendar(identifier: .persian)
        let persianDate = dateFormatter.string(from: date)
        let splitDate = persianDate.components(separatedBy: "/")
        let year = Int(splitDate[0]) ?? 1300
        let month = Int(splitDate[1]) ?? 1
        let day = Int(splitDate[2]) ?? 1
        
        return (year: year , month: month, day: day )
    }
    
    func convertDate(persianDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.calendar = Calendar(identifier: .persian)
        
        let date = dateFormatter.date(from: persianDate)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.calendar = Calendar(identifier: .persian)
        let gregorianDate = df.string(from: date!)
        df.string(from: date!)
        return df.date(from: gregorianDate)!
    }
    
    func nextDay(by date: String) -> Date {
        let d = convertDate(persianDate: date)
        var call = Calendar(identifier: .gregorian)
        call.timeZone = TimeZone(abbreviation: "GMT")!
        return call.date(byAdding: .day, value: 1, to: d)!
    }
    
    func backDay(by date: String) -> Date {
        let d = convertDate(persianDate: date)
        var call = Calendar(identifier: .gregorian)
        call.timeZone = TimeZone(abbreviation: "GMT")!
        return call.date(byAdding: .day, value: -1, to: d)!
    }
}
