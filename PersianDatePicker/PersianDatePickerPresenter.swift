//
//  PersianDatePickerPresenter.swift
//  PersianDatePicker
//
//  Created by Farhad Faramarzi on 10/7/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

public struct PersianDatePickerPresenter {
    
    public init() {}
    
    private var pickerview = PersianPickerView(frame: .zero)
    
    public func show(in viewController: UIViewController, callBack: @escaping (_ persianDate: String) -> ()) {
        pickerview.backgroundColor = .clear
        pickerview.layer.cornerRadius = 10
        pickerview.layer.masksToBounds = true
        
        viewController.view.addSubview(pickerview)
        pickerview.translatesAutoresizingMaskIntoConstraints = false
        pickerview.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
        pickerview.widthAnchor.constraint(equalToConstant: 280).isActive = true
        pickerview.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true

        UIView.transition(with: pickerview, duration: 0.5, options: .showHideTransitionViews, animations: {
            self.pickerview.frame.origin.y = 100
        }, completion: nil)
        
        
        pickerview.onActionDismiss = {
            self.pickerview.removeFromSuperview()
        }
        
        pickerview.onActionOk = { pdate in
            callBack(pdate)
        }
    }
}
