
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
    public typealias Listener = (_ year: Int, _ month: Int, _ day: Int) -> Void
    
    @IBInspectable var fontColor: UIColor = .black
    
    public enum Style {
        case short
        case long
    }
    
    public var onChange: (Listener)?
    
    public var year = 1300
    public var month = 1
    public var day = 1
    public var font: UIFont?

    public var pickerStyle: Style = .long {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    fileprivate var monthName: MonthName = .farvardin
    fileprivate var numberMonth = 1
    fileprivate var pickerView = UIPickerView()
    fileprivate var persianDatePresenter: PersianDatePresenter!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        addSubview(pickerView)
        persianDatePresenter = PersianDatePresenter()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let currentDate = persianDatePresenter.getDateToday()
        let currentYear = persianDatePresenter.getYears().filter { (item) -> Bool in
            return item == currentDate.year
        }
        if currentYear.count > 0 {
            let indexYear = currentYear[0] - 1300

            pickerView.selectRow(indexYear, inComponent: 0, animated: true)
            pickerView.selectRow(currentDate.month - 1, inComponent: 1, animated: true)
            year = currentYear[0]
            month = currentDate.month
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

extension PersianDatePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerStyle {
        case .long: return 3
        case .short: return 2
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return persianDatePresenter.getYears().count
            
        case 1:
            return persianDatePresenter.getMonths().count
            
        default:
            return persianDatePresenter.getDays(month: monthName).count
        }
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
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
            let year = String(persianDatePresenter.getYears()[row])
            let persianNumber = format.number(from: year)
            label.text = format.string(from: persianNumber!)

        case 1:
            label.text = persianDatePresenter.getMonths()[row].rawValue
            
        case 2:
            let day = String(persianDatePresenter.getDays(month: monthName)[row])
            let persianNumber = format.number(from: day)
            label.text = format.string(from: persianNumber!)
            
        default:
            break
        }
        
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            year = persianDatePresenter.getYears()[row]
            
        case 1:
            monthName = persianDatePresenter.getMonths()[row]
            numberMonth = row + 1

            if pickerStyle == .long {
                pickerView.reloadComponent(2)

                switch monthName {
                case .farvardin, .ordibehesht, .khordad, .tir, .mordad, .shahrivar:
                    if day >= 31 {
                        day = 31
                    }
                    
                case .mehr, .aban, .azar, .dey, .bahman:
                    if day >= 30 {
                        day = 30
                    }
                case .esfand:
                    if day >= 29 {
                        day = 29
                    }
                }
            }
            
        case 2:
            day = persianDatePresenter.getDays(month: monthName)[row]
            
        default:
            break
        }
        self.onChange?(year, numberMonth, day)
    }
}





