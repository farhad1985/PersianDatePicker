//
//  PersianPickerView.swift
//  PersianPickerView
//
//  Created by Farhad on 5/7/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import UIKit

public class PersianPickerView: UIView {
    
    var year = 1300
    var month = 1
    var day = 1
    public var delegate: PersianDateDelegate?
    
    fileprivate var monthName: MonthName = .farvardin
    fileprivate var pickerView = UIPickerView()
    fileprivate var persianDatePresenter: PersianDatePresenter!
    
    override init(frame: CGRect) {
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

extension PersianPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
        
        switch component {
        case 0:
            label.text = String(persianDatePresenter.getYears()[row])
            
        case 1:
            label.text = persianDatePresenter.getMonths()[row].rawValue
            
        default:
            label.text = String(persianDatePresenter.getDays(month: monthName)[row])
        }

        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            year = persianDatePresenter.getYears()[row]
            
        case 1:
            monthName = persianDatePresenter.getMonths()[row]
            
        default:
            day = persianDatePresenter.getDays(month: monthName)[row]
        }
        
        delegate?.persianDate(persianPickerView: self, year: year, month: monthName.rawValue, day: day)
    }
}





