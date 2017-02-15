//
//  UIViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
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
				return layer.borderColor?.uiColor
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
			guard !isFirstResponder else {
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
				return frame.size.height
			}
			set {
				frame.size.height = newValue
			}
		}
		
		/// SwifterSwift: Check if view is in RTL format.
		public var isRightToLeft: Bool {
			if #available(iOS 10.0, *, tvOS 10.0, *) {
				return effectiveUserInterfaceLayoutDirection == .rightToLeft
			} else {
				return false
			}
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
				return layer.shadowColor?.uiColor
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
		
		/// SwifterSwift: Size of view.
		public var size: CGSize {
			get {
				return frame.size
			}
			set {
				width = newValue.width
				height = newValue.height
			}
		}
		
		/// SwifterSwift: Get view's parent view controller
		public var parentViewController: UIViewController? {
			weak var parentResponder: UIResponder? = self
			while parentResponder != nil {
				parentResponder = parentResponder!.next
				if let viewController = parentResponder as? UIViewController {
					return viewController
				}
			}
			return nil
		}
		
		/// SwifterSwift: Width of view.
		public var width: CGFloat {
			get {
				return frame.size.width
			}
			set {
				frame.size.width = newValue
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
		                      offset: CGSize = .zero,
		                      opacity: Float = 0.5) {
			layer.shadowColor = color.cgColor
			layer.shadowOffset = offset
			layer.shadowRadius = radius
			layer.shadowOpacity = opacity
			layer.masksToBounds = true
		}
		
		/// SwifterSwift: Add array of subviews to view.
		///
		/// - Parameter subviews: array of subviews to add to self.
		public func addSubviews(_ subviews: [UIView]) {
			subviews.forEach({self.addSubview($0)})
		}
		
		/// SwifterSwift: Fade in view.
		///
		/// - Parameters:
		///   - duration: animation duration in seconds (default is 1 second).
		///   - completion: optional completion handler to run with animation finishes (default is nil)
		public func fadeIn(duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
			if isHidden {
				isHidden = false
			}
			UIView.animate(withDuration: duration, animations: {
				self.alpha = 1
			}, completion: completion)
		}
		
		/// SwifterSwift: Fade out view.
		///
		/// - Parameters:
		///   - duration: animation duration in seconds (default is 1 second).
		///   - completion: optional completion handler to run with animation finishes (default is nil)
		public func fadeOut(duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
			if isHidden {
				isHidden = false
			}
			UIView.animate(withDuration: duration, animations: {
				self.alpha = 0
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
		public func removeSubviews() {
			subviews.forEach({$0.removeFromSuperview()})
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
			let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
			let aDuration = animated ? duration : 0
			UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
				self.transform = self.transform.rotated(by: angleWithType)
			}, completion: completion)
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
			let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
			let aDuration = animated ? duration : 0
			UIView.animate(withDuration: aDuration, animations: {
				self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
			}, completion: completion)
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
				transform = transform.scaledBy(x: offset.x, y: offset.y)
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
		
		/// SwifterSwift: Add Visual Format constraints.
		///
		/// - Parameters:
		///   - withFormat: visual Format language
		///   - views: array of views which will be accessed starting with index 0 (example: [v0], [v1], [v2]..)
		@available(iOS 9, *) public func addConstraints(withFormat: String, views: UIView...) {
			// https://videos.letsbuildthatapp.com/
			var viewsDictionary: [String: UIView] = [:]
			for (index, view) in views.enumerated() {
				let key = "v\(index)"
				view.translatesAutoresizingMaskIntoConstraints = false
				viewsDictionary[key] = view
			}
			addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
		}
		
		/// SwifterSwift: Anchor all sides of the view into it's superview.
		@available(iOS 9, *) public func fillToSuperview() {
			// https://videos.letsbuildthatapp.com/
			translatesAutoresizingMaskIntoConstraints = false
			if let superview = superview {
				leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
				rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
				topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
				bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
			}
		}
		
		/// SwifterSwift: Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
		///
		/// - Parameters:
		///   - top: current view's top anchor will be anchored into the specified anchor
		///   - left: current view's left anchor will be anchored into the specified anchor
		///   - bottom: current view's bottom anchor will be anchored into the specified anchor
		///   - right: current view's right anchor will be anchored into the specified anchor
		///   - topConstant: current view's top anchor margin
		///   - leftConstant: current view's left anchor margin
		///   - bottomConstant: current view's bottom anchor margin
		///   - rightConstant: current view's right anchor margin
		///   - widthConstant: current view's width
		///   - heightConstant: current view's height
		/// - Returns: array of newly added constraints (if applicable).
		@available(iOS 9, *) @discardableResult public func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
			// https://videos.letsbuildthatapp.com/
			translatesAutoresizingMaskIntoConstraints = false
			
			var anchors = [NSLayoutConstraint]()
			
			if let top = top {
				anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
			}
			
			if let left = left {
				anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
			}
			
			if let bottom = bottom {
				anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
			}
			
			if let right = right {
				anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
			}
			
			if widthConstant > 0 {
				anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
			}
			
			if heightConstant > 0 {
				anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
			}
			
			anchors.forEach({$0.isActive = true})
			
			return anchors
		}
		
		/// SwifterSwift: Anchor center X into current view's superview with a constant margin value.
		///
		/// - Parameter withConstant: constant of the anchor constraint.
		@available(iOS 9, *) public func anchorCenterXToSuperview(withConstant: CGFloat = 0) {
			// https://videos.letsbuildthatapp.com/
			translatesAutoresizingMaskIntoConstraints = false
			if let anchor = superview?.centerXAnchor {
				centerXAnchor.constraint(equalTo: anchor, constant: withConstant).isActive = true
			}
		}
		
		/// SwifterSwift: Anchor center Y into current view's superview with a constant margin value.
		///
		/// - Parameter withConstant: constant of the anchor constraint.
		@available(iOS 9, *) public func anchorCenterYToSuperview(constant: CGFloat = 0) {
			// https://videos.letsbuildthatapp.com/
			translatesAutoresizingMaskIntoConstraints = false
			if let anchor = superview?.centerYAnchor {
				centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
			}
		}
		
		/// SwifterSwift: Anchor center X and Y into current view's superview
		@available(iOS 9, *) public func anchorCenterSuperview() {
			// https://videos.letsbuildthatapp.com/
			anchorCenterXToSuperview()
			anchorCenterYToSuperview()
		}
		
	}
#endif
