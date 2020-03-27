//
//  UIColor+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Initializers
public extension UIColor {
    //Custom Color    
    convenience init(hex: Int, alpha: CGFloat) {
        let r = CGFloat((hex & 0xFF0000) >> 16)/255
        let g = CGFloat((hex & 0xFF00) >> 8)/255
        let b = CGFloat(hex & 0xFF)/255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        let red, green, blue, alpha: CGFloat
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        chars = ["F","F"] + chars
        alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
        red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
        green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
        blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
    
    /// Create UIColor from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1)
    convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        var trans: CGFloat {
            if transparency > 1 {
                return 1
            } else if transparency < 0 {
                return 0
            } else {
                return transparency
            }
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    static var random: UIColor {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return UIColor(red: r, green: g, blue: b)
    }
}


