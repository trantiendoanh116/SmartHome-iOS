//
//  UIAlertController+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit
import AudioToolbox

// MARK: - Initializers
extension UIAlertController {
	
    /// Create new alert view controller.
    ///
    /// - Parameters:
    ///   - style: alert controller's style.
    ///   - title: alert controller's title.
    ///   - message: alert controller's message (default is nil).
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    convenience init(style: UIAlertController.Style, sourceView: UIView? = nil,sourceBarItem: UIBarButtonItem? = nil, title: String? = nil, message: String? = nil, tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        
        let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        let root = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.view
        
        //self.responds(to: #selector(getter: popoverPresentationController))
        if let source = sourceView {
            Log("----- source")
            popoverPresentationController?.sourceView = source
            popoverPresentationController?.sourceRect = source.bounds
        }else if isPad, style == .actionSheet, sourceBarItem != nil{
             Log("----- is pad, barItem ---")
            popoverPresentationController?.sourceView = root
            popoverPresentationController?.barButtonItem = sourceBarItem
        }else if isPad, let source = root, style == .actionSheet {
            Log("----- is pad")
            popoverPresentationController?.sourceView = source
            popoverPresentationController?.sourceRect = CGRect(x: source.bounds.midX, y: source.bounds.midY, width: 0, height: 0)
            //popoverPresentationController?.permittedArrowDirections = .down
            popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
        }
        
        if let color = tintColor {
            self.view.tintColor = color
        }
    }
}


// MARK: - Methods
extension UIAlertController {
    
    /// Present alert view controller in the current view controller.
    ///
    /// - Parameters:
    ///   - animated: set true to animate presentation of alert controller (default is true).
    ///   - vibrate: set true to vibrate the device while presenting the alert (default is false).
    ///   - completion: an optional completion handler to be called after presenting alert controller (default is nil).
    public func show(animated: Bool = true, vibrate: Bool = false, style: UIBlurEffect.Style? = nil, completion: (() -> Void)? = nil) {
        
        if let style = style {
            for subview in view.allSubViewsOf(type: UIVisualEffectView.self) {
                subview.effect = UIBlurEffect(style: style)
            }
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(self, animated: animated, completion: completion)
            if vibrate {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
    /// Add an action to Alert
    ///
    /// - Parameters:
    ///   - title: action title
    ///   - style: action style (default is UIAlertActionStyle.default)
    ///   - isEnabled: isEnabled status for action (default is true)
    ///   - handler: optional action handler to be called when button is tapped (default is nil)
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        //let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        //let action = UIAlertAction(title: title, style: isPad && style == .cancel ? .default : style, handler: handler)
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
    
    /// Set alert's title, font and color
    ///
    /// - Parameters:
    ///   - title: alert title
    ///   - font: alert title font
    ///   - color: alert title color
    func set(title: String?, font: UIFont, color: UIColor) {
        if title != nil {
            self.title = title
        }
        setTitle(font: font, color: color)
    }
    
    func setTitle(font: UIFont, color: UIColor) {
        guard let title = self.title else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)
        setValue(attributedTitle, forKey: "attributedTitle")
    }
    
    /// Set alert's message, font and color
    ///
    /// - Parameters:
    ///   - message: alert message
    ///   - font: alert message font
    ///   - color: alert message color
    func set(message: String?, font: UIFont, color: UIColor) {
        if message != nil {
            self.message = message
        }
        setMessage(font: font, color: color)
    }
    
    func setMessage(font: UIFont, color: UIColor) {
        guard let message = self.message else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let attributedMessage = NSMutableAttributedString(string: message, attributes: attributes)
        setValue(attributedMessage, forKey: "attributedMessage")
    }
    
    /// Set alert's content viewController
    ///
    /// - Parameters:
    ///   - vc: ViewController
    ///   - height: height of content viewController
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func addImage(image: UIImage){
        let newWidth = UIScreen.main.bounds.width * 0.90
        let newHeight = UIScreen.main.bounds.height * 0.70
        let maxSize = CGSize(width: newWidth, height: newHeight)
        let imgSize = image.size
         Log("Phone: width = \(UIScreen.main.bounds.width), height = \(UIScreen.main.bounds.height)")
        Log("Image: width = \(imgSize.width), height = \(imgSize.height)")
        var ratio: CGFloat!
        if imgSize.width > imgSize.height {
            ratio = maxSize.width / imgSize.width
        }else{
            ratio = maxSize.height / imgSize.height
        }
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        var resizedImage = image.imageWithSize(size: scaledSize)
        
        //Route image
        if resizedImage.size.width > resizedImage.size.height {
            resizedImage = resizedImage.rotate(radians: .pi/2)
        }
        
        let left = (maxSize.width - resizedImage.size.width) / 3 + 3
        resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsets(top: 0,left: -left,bottom: 0,right: 0))

        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
    
        func addImageProduct(image: UIImage){
            let scaleSze = CGSize(width: 245, height: 245/image.size.width*image.size.height)
            let reSizedImage = image.imageWithSize(size: scaleSze)
    
            let uiImageAlertAction = UIAlertAction(title: "", style: .default, handler: nil)
            uiImageAlertAction.setValue(reSizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
    
            self.addAction(uiImageAlertAction)
            self.addAction(UIAlertAction(title: "all_btn_cancel".localized, style: .cancel, handler: nil))
    
        }
    
    func setWidth(newWidth: CGFloat){
        // Filtering width constraints of alert base view width
        let widthConstraints = self.view.constraints.filter({ return $0.firstAttribute == .width })
        self.view.removeConstraints(widthConstraints)

        // Adding constraint for alert base view
        let widthConstraint = NSLayoutConstraint(item: self.view!,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: newWidth)
        self.view.addConstraint(widthConstraint)
        let firstContainer = self.view.subviews[0]
        // Finding first child width constraint
        let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        firstContainer.removeConstraints(constraint)
        // And replacing with new constraint equal to alert.view width constraint that we setup earlier
        self.view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: self.view,
                                                    attribute: .width,
                                                    multiplier: 1.0,
                                                    constant: 0))
        // Same for the second child with width constraint with 998 priority
        let innerBackground = firstContainer.subviews[0]
        let innerConstraints = innerBackground.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        innerBackground.removeConstraints(innerConstraints)
        firstContainer.addConstraint(NSLayoutConstraint(item: innerBackground,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: firstContainer,
                                                        attribute: .width,
                                                        multiplier: 1.0,
                                                        constant: 0))
    }
    
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16"){
                subView.removeConstraint(constraint)
            }
        }
    }
}

