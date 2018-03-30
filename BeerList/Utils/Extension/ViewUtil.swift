//
//  ViewUtil.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 30/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class ViewUtil: NSObject {
    
    class func viewControllerFromStoryboardWithIdentifier(_ name: String, identifier: String = "")->UIViewController?{
        
        let storyboard : UIStoryboard = UIStoryboard(name: name, bundle: nil)
        
        if identifier != "" {
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
        else {
            return storyboard.instantiateInitialViewController()
        }
    }
}

extension UIView {
    
    func addRoundedBorder() {
        layer.cornerRadius = frame.height / 2
    }
    
    func round(corners: UIRectCorner, with cornerRadius: Int = 16, andSetBackgroundColor color: UIColor = .white) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        self.layer.backgroundColor = color.cgColor
        self.layer.mask = rectShape
    }
    
    //Proportions of Iphone 5SE
    static func heightScaleProportion() -> CGFloat {
        return UIScreen.main.bounds.height / 568.0
    }
    
    static func widthScaleProportion() -> CGFloat {
        return UIScreen.main.bounds.width / 320.0
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    
    @IBInspectable var shouldRasterize: Bool {
        get {
            return self.layer.shouldRasterize
        }
        set {
            self.layer.shouldRasterize = newValue
        }
    }
    
    @IBInspectable var roundedByHeight: Bool {
        get {
            return self.layer.cornerRadius == self.frame.height
        }
        set {
            if newValue == true {
                self.layer.cornerRadius = self.frame.height / 8
                //self.layer.masksToBounds = true
            } else {
                self.layer.cornerRadius = 0
            }
        }
    }
    
    @IBInspectable var roundedCircle: Bool {
        get {
            return self.layer.cornerRadius == self.frame.height / 2
        }
        set {
            if newValue == true {
                self.layer.cornerRadius = self.frame.height / 2
            } else {
                self.layer.cornerRadius = 0
            }
        }
    }
}
