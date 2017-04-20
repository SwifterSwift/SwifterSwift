//
//  NSViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(macOS)
import Cocoa

// MARK: - Properties
public extension NSView {
	
	@IBInspectable
	/// SwifterSwift: Border color of view; also inspectable from Storyboard.
	public var borderColor: NSColor? {
		get {
			return layer?.borderColor?.nsColor
		}
		set {
			wantsLayer = true
			layer?.borderColor = newValue?.cgColor
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Border width of view; also inspectable from Storyboard.
	public var borderWidth: CGFloat {
		get {
			return layer?.borderWidth ?? 0
		}
		set {
			wantsLayer = true
			layer?.borderWidth = newValue
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
	public var cornerRadius: CGFloat {
		get {
			return layer?.cornerRadius ?? 0
		}
		set {
			wantsLayer = true
			layer?.masksToBounds = true
			layer?.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
		}
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
	
	@IBInspectable
	/// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
	public var shadowColor: NSColor? {
		get {
			return layer?.shadowColor?.nsColor
		}
		set {
			wantsLayer = true
			layer?.shadowColor = newValue?.cgColor
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
	public var shadowOffset: CGSize {
		get {
			return layer?.shadowOffset ?? CGSize.zero
		}
		set {
			wantsLayer = true
			layer?.shadowOffset = newValue
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
	public var shadowOpacity: Float {
		get {
			return layer?.shadowOpacity ?? 0
		}
		set {
			wantsLayer = true
			layer?.shadowOpacity = newValue
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
	public var shadowRadius: CGFloat {
		get {
			return layer?.shadowRadius ?? 0
		}
		set {
			wantsLayer = true
			layer?.shadowRadius = newValue
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
extension NSView {
	
	/// SwifterSwift: Add array of subviews to view.
	///
	/// - Parameter subviews: array of subviews to add to self.
	public func addSubviews(_ subviews: [NSView]) {
		subviews.forEach({self.addSubview($0)})
	}
	
	/// SwifterSwift: Remove all subviews in view.
	public func removeSubviews() {
		subviews.forEach({$0.removeFromSuperview()})
	}
	
}
	
#endif
