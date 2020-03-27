//
//  UIApplication+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}
