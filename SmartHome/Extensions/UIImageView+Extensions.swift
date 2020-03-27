//
//  UIImageView+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
      }
}
