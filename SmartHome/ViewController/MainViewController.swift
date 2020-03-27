//
//  MainViewController.swift
//  SmartHome
//
//  Created by Alpha on 3/3/20.
//  Copyright © 2020 Alpha. All rights reserved.
//


import UIKit

class MainViewController: UINavigationController {

    static let shared = MainViewController()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(initApp: Bool? = false) {
        super.init(rootViewController: HomeViewController())
    }
    

    
}
