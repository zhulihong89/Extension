//
//  UIColor+Extension.swift
//  Extension
//
//  Created by lihong on 2020/7/2.
//  Copyright © 2020 lihong. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(rgba rgbValue: Int) {
        self.init(red: CGFloat(((Int64(rgbValue) & 0xFF000000) >> 24)) / 255.0, green: CGFloat(((rgbValue & 0xFF0000) >> 16)) / 255.0, blue: CGFloat(((rgbValue & 0xFF00) >> 8)) / 255.0, alpha: CGFloat(rgbValue & 0xFF) / 255.0)
    }
        
    public convenience init(rgb rgbValue: Int, alpha: CGFloat = 1) {
        self.init(rgba: (rgbValue << 8) | Int(alpha * 255))
    }
}

extension UIColor {
    public func add(_ overlay: UIColor) -> UIColor {
        var bgR: CGFloat = 0
        var bgG: CGFloat = 0
        var bgB: CGFloat = 0
        var bgA: CGFloat = 0
        
        var fgR: CGFloat = 0
        var fgG: CGFloat = 0
        var fgB: CGFloat = 0
        var fgA: CGFloat = 0
        
        self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
        
        let r = fgA * fgR + (1 - fgA) * bgR
        let g = fgA * fgG + (1 - fgA) * bgG
        let b = fgA * fgB + (1 - fgA) * bgB
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    public static func +(lhs: UIColor, rhs: UIColor) -> UIColor {
        return lhs.add(rhs)
    }
}
