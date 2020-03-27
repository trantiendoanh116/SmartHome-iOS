//
//  UISearchBar+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
    }
    
    func setSearchIcon(image: UIImage) {
        setImage(image, for: .search, state: .normal)
    }
    
    func setClearIcon(image: UIImage) {
        setImage(image, for: .clear, state: .normal)
    }
}
