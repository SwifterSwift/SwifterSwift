//
//  CGColorExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGColor {

	#if canImport(UIKit)
	/// SwifterSwift: UIColor.
	public var uiColor: UIColor? {
		return UIColor(cgColor: self)
	}
	#endif

	#if canImport(Cocoa)
	/// SwifterSwift: NSColor.
	public var nsColor: NSColor? {
		return NSColor(cgColor: self)
	}
	#endif

}
#endif
