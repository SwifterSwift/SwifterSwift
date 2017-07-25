//
//  NSAttributedStringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 26/11/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif


// MARK: - Properties
public extension NSAttributedString {
	
	#if os(iOS)
	/// SwifterSwift: Bolded string.
	public var bolded: NSAttributedString {
		return applying(attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif
	
	/// SwifterSwift: Underlined string.
	public var underlined: NSAttributedString {
		return applying(attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle])
	}
	
	#if os(iOS)
	/// SwifterSwift: Italicized string.
	public var italicized: NSAttributedString {
		return applying(attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif
	
	/// SwifterSwift: Struckthrough string.
	public var struckthrough: NSAttributedString {
		return applying(attributes: [NSAttributedStringKey.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue)])
	}
}

// MARK: - Methods
public extension NSAttributedString {
	
	/// SwifterSwift: Applies given attributes to the new instance
	/// of NSAttributedString initialized with self object
	///
	/// - Parameter attributes: Dictionary of attributes
	/// - Returns: NSAttributedString with applied attributes
	fileprivate func applying(attributes: [NSAttributedStringKey: Any]) -> NSAttributedString {
		let copy = NSMutableAttributedString(attributedString: self)
		let range = (string as NSString).range(of: string)
		copy.addAttributes(attributes, range: range)
		
		return copy
	}
	
	#if os(macOS)
	/// SwifterSwift: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: NSColor) -> NSAttributedString {
		return applying(attributes: [NSAttributedStringKey.foregroundColor: color])
	}
	#else
	/// SwifterSwift: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return applying(attributes: [NSAttributedStringKey.foregroundColor: color])
	}
	#endif
}

// MARK: - Operators
public extension NSAttributedString {
	
	/// SwifterSwift: Add a NSAttributedString to another NSAttributedString.
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add to.
	///   - rhs: NSAttributedString to add.
	public static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
		let ns = NSMutableAttributedString(attributedString: lhs)
		ns.append(rhs)
		lhs = ns
	}
}
