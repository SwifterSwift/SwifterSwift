//
//  UIViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - enums

/// SwifterSwift: Shake directions of a view.
///
/// - horizontal: Shake left and right.
/// - vertical: Shake up and down.
public enum ShakeDirection {
	case horizontal
	case vertical
}

/// SwifterSwift: Angle units.
///
/// - degrees: degrees.
/// - radians: radians.
public enum AngleUnit {
	case degrees
	case radians
}

/// SwifterSwift: Shake animations types.
///
/// - linear: linear animation.
/// - easeIn: easeIn animation
/// - easeOut: easeOut animation.
/// - easeInOut: easeInOut animation.
public enum ShakeAnimationType {
	case linear
	case easeIn
	case easeOut
	case easeInOut
}


// MARK: - Properties
public extension UIView {
	
	@IBInspectable
	/// SwifterSwift: Border color of view; also inspectable from Storyboard.
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
	/// SwifterSwift: Border width of view; also inspectable from Storyboard.
	public var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
	public var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.masksToBounds = true
			layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
		}
	}
	
	/// SwifterSwift: First responder.
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
	
	// SwifterSwift: Height of view.
	public var height: CGFloat {
		get {
			return self.frame.size.height
		}
		set {
			self.frame.size.height = newValue
		}
	}
	
	/// SwifterSwift: Check if view is in RTL format.
	public var isRightToLeft: Bool {
		if #available(iOS 10.0, *) {
			return effectiveUserInterfaceLayoutDirection == .rightToLeft
		} else {
			return false
		}
	}
	
	/// SwifterSwift: Check if view is visible in screen currently and not hidden.
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
	
	/// SwifterSwift: Take screenshot of view (if applicable).
	public var screenshot: UIImage? {
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
	
	@IBInspectable
	/// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
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
	/// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
	public var shadowOffset: CGSize {
		get {
			return layer.shadowOffset
		}
		set {
			layer.shadowOffset = newValue
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
	public var shadowOpacity: Float {
		get {
			return layer.shadowOpacity
		}
		set {
			layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
	public var shadowRadius: CGFloat {
		get {
			return layer.shadowRadius
		}
		set {
			layer.shadowRadius = newValue
		}
	}
	
	// SwifterSwift: Size of view.
	public var size: CGSize {
		get {
			return self.frame.size
		}
		set {
			self.width = newValue.width
			self.height = newValue.height
		}
	}
	
	// SwifterSwift: Width of view.
	public var width: CGFloat {
		get {
			return self.frame.size.width
		}
		set {
			self.frame.size.width = newValue
		}
	}
	
}


// MARK: - Methods
public extension UIView {
	
	/// SwifterSwift: Set some or all corners radiuses of view.
	///
	/// - Parameters:
	///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
	///   - radius: radius for selected corners.
	public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
		let maskPath = UIBezierPath(roundedRect: bounds,
		                            byRoundingCorners: corners,
		                            cornerRadii: CGSize(width: radius, height: radius))
		let shape = CAShapeLayer()
		shape.path = maskPath.cgPath
		layer.mask = shape
	}
	
	/// SwifterSwift: Add shadow to view.
	///
	/// - Parameters:
	///   - color: shadow color (default is #137992).
	///   - radius: shadow radius (default is 3).
	///   - offset: shadow offset (default is .zero).
	///   - opacity: shadow opacity (default is 0.5).
	public func addShadow(ofColor color: UIColor = UIColor(hex: 0x137992),
	                      radius: CGFloat = 3,
	                      offset: CGSize = CGSize.zero,
	                      opacity: Float = 0.5) {
		layer.shadowColor = color.cgColor
		layer.shadowOffset = offset
		layer.shadowRadius = radius
		layer.shadowOpacity = opacity
		layer.masksToBounds = true
	}
	
	/// SwifterSwift: Add array of subviews to view.
	///
	/// - Parameter subViews: array of subviews to add to self.
	public func add(subViews: [UIView]) {
		subViews.forEach({self.addSubview($0)})
	}
	
	/// SwifterSwift: Fade in view.
	///
	/// - Parameters:
	///   - duration: animation duration in seconds (default is 1 second).
	///   - completion: optional completion handler to run with animation finishes (default is nil)
	public func fadeIn(duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
		if self.isHidden {
			self.isHidden = false
		}
		UIView.animate(withDuration: duration, animations: {
			self.alpha = 0
		}, completion: completion)
	}
	
	/// SwifterSwift: Fade out view.
	///
	/// - Parameters:
	///   - duration: animation duration in seconds (default is 1 second).
	///   - completion: optional completion handler to run with animation finishes (default is nil)
	public func fadeOut(duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
		if self.isHidden {
			self.isHidden = false
		}
		UIView.animate(withDuration: duration, animations: {
			self.alpha = 1
		}, completion: completion)
	}
	
	/// SwifterSwift: Load view from nib.
	///
	/// - Parameters:
	///   - named: nib name.
	///   - bundle: bundle of nib (default is nil).
	/// - Returns: optional UIView (if applicable).
	class func loadFromNib(named: String, bundle : Bundle? = nil) -> UIView? {
		return UINib(nibName: named, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
	}
	
	/// SwifterSwift: Remove all subviews in view.
	public func removeSubViews() {
		self.subviews.forEach({$0.removeFromSuperview()})
	}
	
	/// SwifterSwift: Remove all gesture recognizers from view.
	public func removeGestureRecognizers() {
		gestureRecognizers?.forEach(removeGestureRecognizer)
	}
	
	/// SwifterSwift: Rotate view by angle on relative axis.
	///
	/// - Parameters:
	///   - angle: angle to rotate view by.
	///   - type: type of the rotation angle.
	///   - animated: set true to animate rotation (default is true).
	///   - duration: animation duration in seconds (default is 1 second).
	///   - completion: optional completion handler to run with animation finishes (default is nil).
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
	
	/// SwifterSwift: Rotate view to angle on fixed axis.
	///
	/// - Parameters:
	///   - angle: angle to rotate view to.
	///   - type: type of the rotation angle.
	///   - animated: set true to animate rotation (default is false).
	///   - duration: animation duration in seconds (default is 1 second).
	///   - completion: optional completion handler to run with animation finishes (default is nil).
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
	
	/// SwifterSwift: Scale view by offset.
	///
	/// - Parameters:
	///   - offset: scale offset
	///   - animated: set true to animate scaling (default is false).
	///   - duration: animation duration in seconds (default is 1 second).
	///   - completion: optional completion handler to run with animation finishes (default is nil).
	public func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
		if animated {
			UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
				self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
			}, completion: completion)
		} else {
			self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
			completion?(true)
		}
	}
	
	/// SwifterSwift: Shake view.
	///
	/// - Parameters:
	///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
	///   - duration: animation duration in seconds (default is 1 second).
	///   - animationType: shake animation type (default is .easeOut).
	///   - completion: optional completion handler to run with animation finishes (default is nil).
	public func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
		
		CATransaction.begin()
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
		CATransaction.setCompletionBlock(completion)
		animation.duration = duration
		animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
		layer.add(animation, forKey: "shake")
		CATransaction.commit()
	}
	
}
