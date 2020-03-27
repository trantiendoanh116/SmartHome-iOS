//
//  UITextView+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UITextView {
    /// addButtonDone in keyboard
//        @IBInspectable var doneAccessory: Bool{
//            get{
//                return self.doneAccessory
//            }
//            set (hasDone) {
//                if hasDone{
//                    addDoneButtonOnKeyboard()
//                }
//            }
//        }
//        
//        func addDoneButtonOnKeyboard()
//        {
//            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//            doneToolbar.barStyle = .default
//            
//            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
//            
//            let items = [flexSpace, done]
//            doneToolbar.items = items
//            doneToolbar.sizeToFit()
//            
//            self.inputAccessoryView = doneToolbar
//        }
//        
//        @objc func doneButtonAction()
//        {
//            self.resignFirstResponder()
//        }
        
    //    @IBInspectable var paddingLeft: CGFloat {
    //        get {
    //            return leftView!.frame.size.width
    //        }
    //        set {
    //            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
    //            leftView = paddingView
    //            leftViewMode = .always
    //        }
    //    }
    //
    //    @IBInspectable var paddingRight: CGFloat {
    //        get {
    //            return rightView!.frame.size.width
    //        }
    //        set {
    //            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
    //            rightView = paddingView
    //            rightViewMode = .always
    //        }
    //    }
	
	/// Scroll to the bottom of text view
    func scrollToBottom() {
		let range = NSMakeRange((text as NSString).length - 1, 1)
		scrollRangeToVisible(range)
	}
	
	/// Scroll to the top of text view
    func scrollToTop() {
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}
}
