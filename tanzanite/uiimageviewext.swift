//
//  uiimageviewext.swift
//  tanzanite
//
//  Created by Goktug Yilmaz on 2/20/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, imageName: String) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        image = UIImage(named: imageName)
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, imageName: String, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        image = UIImage(named: imageName)
        if image != nil {
            scaleImageFrameToWidth(width: scaleToWidth)
        } else {
            assertionFailure("EZSwiftExtensions Error: The imageName is invalid!!!")
        }
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, image: UIImage) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.image = image
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, image: UIImage, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        self.image = image
        scaleImageFrameToWidth(width: scaleToWidth)
    }
    
    /// EZSwiftExtensions, scales this ImageView size to fit the given width
    public func scaleImageFrameToWidth(width width: CGFloat) {
        let widthRatio = image!.size.width / width
        let newWidth = image!.size.width / widthRatio
        let newHeigth = image!.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
    }
    
    /// EZSwiftExtensions
    public func roundSquareImage() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
        
}
