//
//  Extensions.swift
//  Guidomia
//
//  Created by sonnguyen on 2021-04-16.

import UIKit

extension Int {
    var roundedWithPrefix: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(Int(million*10)/10)M" // (round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(Int(thousand*10)/10)K" //"\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

extension UIColor {
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
}

