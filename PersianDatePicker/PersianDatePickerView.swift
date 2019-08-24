
//
//  PersianPickerView.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import UIKit

@IBDesignable
public class PersianDatePickerView: UIView {
	//MARK: - Inspectables
	@IBInspectable var fontColor: UIColor = .black
	//MARK: - Properties
	public var year = 1300
	public var month = 1
	public var day = 1

	fileprivate let pickerView = UIPickerView()
    fileprivate var persianDateDataSource = PersianDateDataSource()
	
	public var onChange: (Listener)?
	public var font: UIFont?

    public var style: PersianDatePickerStyle = .long {
		didSet {
            pickerView.reloadAllComponents()
        }
    }
	
	
	//MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
	
	convenience public init(date: Date, timeZone: TimeZone? = nil) {
		self.init()
		setup()
		
		var cal = Calendar(identifier: .persian)
		timeZone.map { cal.timeZone = $0 }
		
		let comps = cal.dateComponents([.day, .month, .year], from: date)
		(year, month, day) = (comps.year!, comps.month!, comps.day!)
	}
    
    private func setup() {
		setupPicker()
		gotoCurrentDate()
    }
	
	
	private func setupPicker() {
		addSubview(pickerView)
		pickerView.dataSource = self
		pickerView.delegate = self
	}
	
    public func setYearsRange(fromYear : Int , toYear : Int) {
        persianDateDataSource.years = Array (fromYear...toYear)
        setDatePicker(year: year, month: month, day: day)
    }
    public func setMaxYear(toYear : Int) {
        persianDateDataSource.years = Array (1300...toYear)
        setDatePicker(year: year, month: month, day: day)
    }
    public func setMinYear(fromYear : Int) {
        persianDateDataSource.years = Array (fromYear...1500)
        setDatePicker(year: year, month: month, day: day)
    }


    public func gotoCurrentDate() {	
        let currentDate = persianDateDataSource.todayCompononents()
        setDatePicker(year: currentDate.year, month: currentDate.month, day: currentDate.day)
    }
    
    public func gotoDate(date: Date) {
        let persianDate = persianDateDataSource.convertToPersian(date: date)
        setDatePicker(year: persianDate.year, month: persianDate.month, day: persianDate.day)
    }
    
    public func setPersianDate(year: Int, month: Int, day: Int) {
        setDatePicker(year: year, month: month, day: day)
    }
    
    public func getGregorianDate() -> Date? {
        return persianDateDataSource.convertToGregorian(year: year, month: month, day: day)
    }
    
    public func getPersianDate() -> String? {
        return persianDateDataSource.getPersianDate(year: year, month: month, day: day)
    }
    
    public func nextDay(by date: String) {
        let d = persianDateDataSource.nextDay(by: date)
        gotoDate(date: d)
    }
    
    public func backDay(by date: String) {
        let d = persianDateDataSource.backDay(by:date)
        gotoDate(date: d)
    }
    
    private func setDatePicker(year: Int, month: Int, day: Int) {
        let yearIndex = persianDateDataSource.years.firstIndex(of: year)!
        let monthIndex = month - 1
        self.year = year
        self.month = month
        self.day = day
        pickerView.selectRow(yearIndex, inComponent: 0, animated: true)
        pickerView.selectRow(monthIndex, inComponent: 1, animated: true)
        
        if style == .long {
            pickerView(pickerView, didSelectRow: day - 1, inComponent: 2)
            pickerView.selectRow(day - 1, inComponent: 2, animated: true)
        }
    }
	
	
    override public func layoutSubviews() {
        super.layoutSubviews()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        pickerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        pickerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
    }
}


//MARK: - PickerView DataSource
extension PersianDatePickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return style.numberOfComponents
    }
	
	
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return persianDateDataSource.years.count
        case 1:
            return persianDateDataSource.persianMonths.count
        default:
			return persianDateDataSource.daysRange(ofYear: year, month: month).count
        }
    }
}


//MARK: - PickerView Delegate
extension PersianDatePickerView: UIPickerViewDelegate {
	public func pickerView(_ pickerView: UIPickerView,
						   viewForRow row: Int,
						   forComponent component: Int,
						   reusing view: UIView?) -> UIView {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = fontColor
		let format = NumberFormatter()
		format.locale = Locale(identifier: "fa_IR")
		
		if let font = self.font {
			label.font = font
		}
		
		switch component {
		case 0:
			let year = String(persianDateDataSource.years[row])
			let persianNumber = format.number(from: year)
			label.text = format.string(from: persianNumber!)
			
		case 1:
			label.text = persianDateDataSource.persianMonths[row]
			
		case 2:
			let day = String(persianDateDataSource.daysRange(ofYear: year, month: month)[row])
			label.text = format.string(from: format.number(from: day)!)
			
		default:
			break
		}
		
		return label
	}
	
	
	public func pickerView(_ pickerView: UIPickerView,
						   didSelectRow row: Int,
						   inComponent component: Int) {
		
		switch component {
		case 0:
			year = persianDateDataSource.years[row]
		case 1:
			month = row + 1
		case 2:
			day = persianDateDataSource.daysRange(ofYear: year, month: month)[row]
		default:
			break
		}
		
		if style == .long {
			pickerView.reloadComponent(2)
		}
		
		self.onChange?(year, month, day)
	}
}

public typealias Listener = (_ year: Int, _ month: Int, _ day: Int) -> Void
public enum PersianDatePickerStyle {
	case short
	case long
	
	fileprivate var numberOfComponents: Int {
		switch self {
		case .short:
			return 2
		case .long:
			return 3
		}
	}
}






