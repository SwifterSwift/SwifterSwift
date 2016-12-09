//
//  UIButtonExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Properties
public extension UIButton {
	
	@IBInspectable
	/// SwifterSwift: Image of disabled state for button; also inspectable from Storyboard.
	public var imageForDisabled: UIImage? {
		get {
			return image(for: .disabled)
		}
		set {
			setImage(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Image of highlighted state for button; also inspectable from Storyboard.
	public var imageForHighlighted: UIImage? {
		get {
			return image(for: .highlighted)
		}
		set {
			setImage(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Image of normal state for button; also inspectable from Storyboard.
	public var imageForNormal: UIImage? {
		get {
			return image(for: .normal)
		}
		set {
			setImage(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Image of selected state for button; also inspectable from Storyboard.
	public var imageForSelected: UIImage? {
		get {
			return image(for: .selected)
		}
		set {
			setImage(newValue, for: .selected)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title color of disabled state for button; also inspectable from Storyboard.
	public var titleColorForDisabled: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title color of highlighted state for button; also inspectable from Storyboard.
	public var titleColorForHighlighted: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title color of normal state for button; also inspectable from Storyboard.
	public var titleColorForNormal: UIColor? {
		get {
			return titleColor(for: .normal)
		}
		set {
			setTitleColor(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title color of selected state for button; also inspectable from Storyboard.
	public var titleColorForSelected: UIColor? {
		get {
			return titleColor(for: .selected)
		}
		set {
			setTitleColor(newValue, for: .selected)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title of disabled state for button; also inspectable from Storyboard.
	public var titleForDisabled: String? {
		get {
			return title(for: .disabled)
		}
		set {
			setTitle(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title of highlighted state for button; also inspectable from Storyboard.
	public var titleForHighlighted: String? {
		get {
			return title(for: .highlighted)
		}
		set {
			setTitle(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title of normal state for button; also inspectable from Storyboard.
	public var titleForNormal: String? {
		get {
			return title(for: .normal)
		}
		set {
			setTitle(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// SwifterSwift: Title of selected state for button; also inspectable from Storyboard.
	public var titleForSelected: String? {
		get {
			return title(for: .selected)
		}
		set {
			setTitle(newValue, for: .selected)
		}
	}
	
}


// MARK: - Methods
public extension UIButton {
	
	/// SwifterSwift: Set image for all states.
	///
	/// - Parameter image: UIImage.
	public func setImageForAllStates(_ image: UIImage) {
		setImage(image, for: .normal)
		setImage(image, for: .selected)
		setImage(image, for: .highlighted)
		setImage(image, for: .disabled)
	}
	
	/// SwifterSwift: Set title color for all states.
	///
	/// - Parameter color: UIColor.
	public func setTitleColorForAllStates(_ color: UIColor) {
		setTitleColor(color, for: .normal)
		setTitleColor(color, for: .selected)
		setTitleColor(color, for: .highlighted)
		setTitleColor(color, for: .disabled)
	}
	
	/// SwifterSwift: Set title for all states.
	///
	/// - Parameter title: title string.
	public func setTitleForAllStates(_ title: String) {
		setTitle(title, for: .normal)
		setTitle(title, for: .selected)
		setTitle(title, for: .highlighted)
		setTitle(title, for: .disabled)
	}
	
}
