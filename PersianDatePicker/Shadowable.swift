//
//  Shadowable.swift
//  Retailer
//
//  Created by Amir Ardalan on 9/23/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import Foundation
import UIKit
protocol Shadowable {
    
}

extension Shadowable where Self :UIView {
    func dropShadow(_ color : UIColor = .black){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
        
    }
    
    
    /// Farhad shaodw
    ///
    /// - Parameters:
    func dropShadow(shadowOpa : Float = 0.1 , size : CGSize = CGSize(width: 1, height: 3) ){
        self.layer.shadowColor = UIColor(red: 254/255, green: 30/255, blue: 154/255, alpha: 0.8).cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = shadowOpa
        self.layer.masksToBounds = false
    }
}
