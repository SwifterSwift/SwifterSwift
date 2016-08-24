//
//  UIViewExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public enum ShakeDirection {
    case horizontal
    case vertical
}

public enum AngleUnit {
    case degrees
    case radians
}

public enum ShakeAnimationType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
}

public extension UIView {
    
    // cool
    /// Shake UIView
    public func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut) {
        
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    // cool
    // FIXME:
    public func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? CGFloat(M_PI) * angle / 180.0 : angle
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform(rotationAngle: angleWithType)
                }, completion: completion)
        } else {
            transform = CGAffineTransform(rotationAngle: angleWithType)
            completion?(true)
        }
    }
    
    // cool
    // FIXME:
    public func rotate(byAngle angle : CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? CGFloat(M_PI) * angle / 180.0 : angle
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.rotated(by: angleWithType)
                }, completion: completion)
        } else {
            self.transform = self.transform.rotated(by: angleWithType)
            completion?(true)
        }
    }
    
    
    // cool
    // FIXME:
    public func scale(by offset: CGPoint, duration: TimeInterval, completion:((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
    }
    
    // cool
    // FIXME:
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    // cool
    // FIXME:
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
    
    // cool
    // FIXME:
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // cool
    // FIXME:
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
    
    // cool
    // FIXME:
    @IBInspectable
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    // cool
    // FIXME:
    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    // cool
    // FIXME:
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    // FIXME:
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
    
    // FIXME:
    public func removeSubViews() {
        self.subviews.forEach({$0.removeFromSuperview()})
    }
    
    // FIXME:
    public func add(subViews: [UIView]) {
        subViews.forEach({self.addSubview($0)})
    }
    
    // FIXME:
    public var isRightToLeft: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
    
    // FIXME:
    public func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    
    // FIXME:
    public func round() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
    }
    
    // cool
    // FIXME:
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
    
    
    // FIXME:
    /// Return true if view is visible in screen currently
    public var isVisible: Bool {
        // https://github.com/hilen/TimedSilver/blob/master/Sources/UIKit/UIView%2BTSExtension.swift
        if self.window == nil || self.isHidden || self.alpha == 0 {
            return true
        }
        let viewRect = self.convert(self.bounds, to: nil)
        guard let window = UIApplication.shared.keyWindow else {
            return true
        }
        return viewRect.intersects(window.bounds) == false
    }
    
    // FIXME:
    public var origin: CGPoint {
        get {
            return self.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    // FIXME:
    public var originX: CGFloat {
        get {
            return self.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    // FIXME:
    public var originY: CGFloat {
        get {
            return self.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
}
