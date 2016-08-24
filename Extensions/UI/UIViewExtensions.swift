//
//  UIViewExtensions.swift
//  SwifterSwift
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

    /// Shake view.
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

    /// Rotate view to angle on fixed axis.
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

    /// Rotate view by angle on relative axis.
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


    /// Scale view by offset.
    public func scale(by offset: CGPoint, duration: TimeInterval, completion:((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
    }

    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// Border color of view; also inspectable from Storyboard.
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

    /// Border width of view; also inspectable from Storyboard.
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Shadow color of view; also inspectable from Storyboard.
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

    /// Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// First responder.
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

    /// Remove all subviews in view.
    public func removeSubViews() {
        self.subviews.forEach({$0.removeFromSuperview()})
    }

    /// Add array of subviews to view.
    public func add(subViews: [UIView]) {
        subViews.forEach({self.addSubview($0)})
    }

    /// Return true if view is in RTL format.
    public var isRightToLeft: Bool {
        if #available(iOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }

    /// Remove all gesture recognizers from view.
    public func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }

    /// Make corners rounded.
    public func roundcorners() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
    }

    /// Take screenshot of view.
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


    /// Return true if view is visible in screen currently and not hidden.
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

    /// Origin coordinates of view.
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

    /// Origin x-coordinates of view.
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

    /// Origin y-coordinates of view.
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
