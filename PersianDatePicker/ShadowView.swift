//
//  ShadowView.swift
//  retailer
//
//  Created by Amir Ardalan on 9/3/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit
class ShadowView : CustomView  {
    
    @IBInspectable var color : UIColor = .black {
        didSet{
            config()
        }
    }
    override  func config(){
        super.config()
        dropShadow(color)
    }
    
}
