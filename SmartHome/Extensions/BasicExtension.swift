//
//  BasicExtension.swift
//
//  Created by Alpha on 10/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func isNotEmpty() -> Bool {
        return !(self.isEmpty)
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func underLine() -> NSAttributedString {
       let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func deafultAtrribute() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        return attributeString
    }
    
    var intValue: Int {
        if let value = Int(self) {
            return value
        }
        return 0
    }
    var floatValue: Float {
        if let value = Float(self) {
            return value
        }
        return 0
    }
    var doubleValue: Double {
        if let value = Double(self) {
            return value
        }
        return 0
    }
    var boolValue: Bool {
        if let value = Bool(self) {
            return value
        }
        return false
    }
}

extension Double {
    var stringValue: String {
        return "\(self)"
    }
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}

extension Int {
    var stringValue: String {
        return "\(self)"
    }
   
    
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
