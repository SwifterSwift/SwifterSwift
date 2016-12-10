//
//  NSAttributedStringExtensions.swift
//  SSTests
//
//  Created by Omar Albeik on 26/11/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Properties
public extension NSAttributedString {

	/// SwifterSwift: Bold string
	public var bold: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		copy.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
		return copy
	}

	/// SwifterSwift: Underlined string
	public var underline: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		copy.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue], range: range)
		return copy
	}

	/// SwifterSwift: Italic string
	public var italic: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		copy.addAttributes([NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
		return copy
	}
	
	/// SwifterSwift: Strikethrough string
	public var strikethrough: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		let attributes = [
			NSStrikethroughStyleAttributeName: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)]
		copy.addAttributes(attributes, range: range)
		
		return copy
	}
	
}


// MARK: - Methods
public extension NSAttributedString {
	
	/// SwifterSwift: Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		copy.addAttributes([NSForegroundColorAttributeName: color], range: range)
		return copy
	}
	
}


// MARK: - Operators
public extension NSAttributedString {
	
	/// SwifterSwift: Add a NSAttributedString to another NSAttributedString
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
