
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
    
    @IBInspectable var fontColor: UIColor = .black
    
    public var delegate: PersianDateDelegate?
    
    var year = 1300
    var month = 1
    var day = 1
    
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
        return 3
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
        
        switch component {
        case 0:
            label.text = String(persianDatePresenter.getYears()[row])
            
        case 1:
            label.text = persianDatePresenter.getMonths()[row].rawValue
            
        case 2:
            label.text = String(persianDatePresenter.getDays(month: monthName)[row])
            
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
            
        case 2:
            day = persianDatePresenter.getDays(month: monthName)[row]
            
        default:
            break
        }
        
        delegate?.persianDate!(persianDatePickerView: self, year: year, monthName: monthName.rawValue, day: day)
        delegate?.persianDate!(persianDatePickerView: self, year: year, month: numberMonth, day: day)
    }
}





