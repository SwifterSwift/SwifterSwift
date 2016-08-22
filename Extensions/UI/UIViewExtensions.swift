//
//  UIViewExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit
public extension UIView {
    
    /// Shake UIView
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    public var firstResponder: UIView? {
        guard !self.isFirstResponder else {
            return self
        }
        for subView in subviews {
            if subView.isFirstResponder {
                return subView
            }
        }
        return nil
    }
    
    public func removeSubViews() {
        self.subviews.forEach({$0.removeFromSuperview()})
    }
    
    public func add(subViews: [UIView]) {
        subViews.forEach({self.addSubview($0)})
    }
    
    public var isRightToLeft: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
    
    public func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    
    
    public func round() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
    }
    
    public var screenShot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0);
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    public func rotate(by degrees: Float, duration: TimeInterval, completion:((Bool) -> Void)) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: CGFloat(degrees * Float(M_PI) / 180))
            }, completion: completion)
    }
    
    public func scale(by offset: CGPoint, duration: TimeInterval, completion:((Bool) -> Void)) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
    }
    
    
    
}
