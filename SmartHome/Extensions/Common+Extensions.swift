//
//  Common+Extensions.swift
//
//  Created by Alpha on 10/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//


import Foundation

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        print("[\(dateInFormat)] \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) : \(funcname) : \(object)")
    #endif
}
