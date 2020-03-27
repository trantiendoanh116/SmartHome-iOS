//
//  Date+Extension.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import Foundation

public extension Date {
    
    /// ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    var iso8601String: String {
    
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    
    /// UNIX timestamp from date.
    var unixTimestamp: Double {
        return timeIntervalSince1970
    }
    
    var timestamp: Int {
        let since1970 = self.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
}


// MARK: - Methods
public extension Date {
    
    func formatBySystem() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
        
    }
    
    func formatByApp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
}


// MARK: - Initializers
public extension Date {

    /// Create new date object from UNIX timestamp.
    ///
    /// - Parameter milliseconds: UNIX timestamp.
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
}


