//
//  UIViewController.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
extension UIViewController {
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIViewController {
    
    
    public func showToast(message: String) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -90)
        self.view.addConstraints([c1, c2, c3])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
    var alertController: UIAlertController? {
           guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
           return alert
       }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        alertController.view.tintColor = UIColor(named: "colorTint")
        DispatchQueue.main.async {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    func showDialog(title: String, message: String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = UIColor(named: "colorTint")
        DispatchQueue.main.async {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func showDialogProcess(spinner: UIActivityIndicatorView) {
        
          spinner.translatesAutoresizingMaskIntoConstraints = false
          spinner.startAnimating()
          view.addSubview(spinner)
          spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
          view.shadowOpacity = 0.5
          view.isUserInteractionEnabled = false
      }
      func hideDialogProcess(spinner: UIActivityIndicatorView) {
          spinner.stopAnimating()
          view.isUserInteractionEnabled = true
          view.shadowOpacity = 1
          
      }
    
    func refreshApp(viewWillShow: UIViewController) {
        let viewController = MainViewController(rootViewController: viewWillShow)
        let scene = self.view.window?.windowScene?.delegate as? SceneDelegate
        scene?.window?.rootViewController = viewController
    }
    
    func refreshApp() {
           let viewController = MainViewController()
           let scene = self.view.window?.windowScene?.delegate as? SceneDelegate
           scene?.window?.rootViewController = viewController
       }
    
    public func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: "all_alert_req_permission_camera_til".localized, message: "all_alert_req_permission_camera_msg".localized, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "all_btn_cancel".localized, style: .default))
        alert.addAction(UIAlertAction(title: "all_alert_req_permission_camera_btn_settings".localized, style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    self.dismiss(animated: true, completion: nil)
                })
            }
        })
        alert.view.tintColor = UIColor(named: "colorTint")
        present(alert, animated: true)
    }
    
    func setDefaultStyleStatusBar(){
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor(named: "colorPrimary")
            
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(named: "colorPrimary")
        }
    }
    
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShowForResizing),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHideForResizing),name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    @objc func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
    
    @objc func keyboardWillHideForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
    
}

