//
//  WKWebView+Extension.swift
//  StoList
//
//  Created by Alpha on 3/2/20.
//  Copyright © 2020 ColorAlpha. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
