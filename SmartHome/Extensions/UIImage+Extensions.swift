//
//  UIImage+Extensions.swift
//
//  Created by Alpha on 11/11/19.
//  Copyright © 2019 ColorAlpha. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///
    /// - Returns: the resized image.
    ///
    func imageWithSize(size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height);
        draw(in: rect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resultingImage!
    }
//
//    func imageWithSize(_ size:CGSize) -> UIImage {
//        var scaledImageRect = CGRect.zero
//
//        let aspectWidth:CGFloat = size.width / self.size.width
//        let aspectHeight:CGFloat = size.height / self.size.height
//        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
//
//        scaledImageRect.size.width = self.size.width * aspectRatio
//        scaledImageRect.size.height = self.size.height * aspectRatio
//        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
//        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
//
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//
//        self.draw(in: scaledImageRect)
//
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return scaledImage!
//    }
    
    /// Resizes an image to the specified size and adds an extra transparent margin at all sides of
    /// the image.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - extraMargin: the extra transparent margin to add to all sides of the image.
    ///
    /// - Returns: the resized image.  The extra margin is added to the input image size.  So that
    ///         the final image's size will be equal to:
    ///         `CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)`
    ///
    func imageWithSize(size: CGSize, extraMargin: CGFloat) -> UIImage? {
        
        let imageSize = CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale);
        let drawingRect = CGRect(x: extraMargin, y: extraMargin, width: size.width, height: size.height)
        draw(in: drawingRect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - roundedRadius: corner radius
    ///
    /// - Returns: the resized image with rounded corners.
    ///
    func imageWithSize(size: CGSize, roundedRadius radius: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            let rect = CGRect(origin: .zero, size: size)
            currentContext.addPath(UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: .allCorners,
                                                cornerRadii: CGSize(width: radius, height: radius)).cgPath)
            currentContext.clip()
            
            //Don't use CGContextDrawImage, coordinate system origin in UIKit and Core Graphics are vertical oppsite.
            draw(in: rect)
            currentContext.drawPath(using: .fillStroke)
            let roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return roundedCornerImage
        }
        return nil
    }
    

    
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }
    
    func rotate(radians: CGFloat) -> UIImage {
           let rotatedSize = CGRect(origin: .zero, size: size)
               .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
               .integral.size
           UIGraphicsBeginImageContext(rotatedSize)
           if let context = UIGraphicsGetCurrentContext() {
               let origin = CGPoint(x: rotatedSize.width / 2.0,
                                    y: rotatedSize.height / 2.0)
               context.translateBy(x: origin.x, y: origin.y)
               context.rotate(by: radians)
               draw(in: CGRect(x: -origin.y, y: -origin.x,
                               width: size.width, height: size.height))
               let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()

               return rotatedImage ?? self
           }

           return self
       }
    
    
}
