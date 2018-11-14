//
//  PersianPickerView.swift
//  PersianDatePicker
//
//  Created by Farhad Faramarzi on 10/7/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

class PersianPickerView: UIView, ViewConnectable {
    
    @IBOutlet weak var pdPicker: PersianDatePickerView!
    
    typealias ActionDismiss = () -> ()
    typealias ActionOk = (String) -> ()

    var onActionDismiss: ActionDismiss?
    
    var onActionOk: ActionOk?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        commit()
        
        backgroundColor = .white
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        onActionDismiss?()
    }
    
    @IBAction func didTapOk(_ sender: Any) {
        onActionOk?(pdPicker.getPersianDate() ?? "")
        onActionDismiss?()
    }
}


protocol ViewConnectable {}

extension ViewConnectable where Self: UIView {
    func commit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let view = views.first as? UIView else {return}
        view.frame = bounds
        addSubview(view)
    }
}
