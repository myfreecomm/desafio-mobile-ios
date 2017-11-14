//
//  UIKit+Extensions.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Custom Colors
    static var navigationBarColor : UIColor {
        return UIColor(hex: 0x343438)
    }
    static var highlightColor : UIColor {
        return UIColor(hex: 0xDD9224)
    }
    static var lineColor : UIColor {
        return UIColor(hex: 0xD7D7D8)
    }
    static var titleColor : UIColor {
        return UIColor(hex: 0x4179A9)
    }
    
    // RGB
    convenience init(_ r: Double, _ g: Double, _ b: Double, _ a: Double) {
        self.init(r/255, g/255, b/255, a)
    }
    
    // Hex to RGB
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

extension UIView {
    func enable() {
        isHidden = false
        isUserInteractionEnabled = true
    }
    func disable() {
        isHidden = true
        isUserInteractionEnabled = false
    }
}

