//
//  CGFloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 SwifterSwift
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
public extension CGFloat {

	/// SwifterSwift: Absolute of CGFloat value.
	public var abs: CGFloat {
		return Swift.abs(self)
	}

	/// SwifterSwift: Ceil of CGFloat value.
	public var ceil: CGFloat {
		return Foundation.ceil(self)
	}

	/// SwifterSwift: Radian value of degree input.
	public var degreesToRadians: CGFloat {
		return CGFloat.pi * self / 180.0
	}

	/// SwifterSwift: Floor of CGFloat value.
	public var floor: CGFloat {
		return Foundation.floor(self)
	}

	/// SwifterSwift: Check if CGFloat is positive.
	public var isPositive: Bool {
		return self > 0
	}

	/// SwifterSwift: Check if CGFloat is negative.
	public var isNegative: Bool {
		return self < 0
	}

	/// SwifterSwift: Int.
	public var int: Int {
		return Int(self)
	}

	/// SwifterSwift: Float.
	public var float: Float {
		return Float(self)
	}

	/// SwifterSwift: Double.
	public var double: Double {
		return Double(self)
	}

	/// SwifterSwift: Degree value of radian input.
	public var radiansToDegrees: CGFloat {
		return self * 180 / CGFloat.pi
	}

}

// MARK: - Methods
public extension CGFloat {

	/// SwifterSwift: Random CGFloat between two CGFloat values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random CGFloat between two CGFloat values.
	public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
		let delta = max - min
		return min + CGFloat(arc4random_uniform(UInt32(delta)))
	}

}
#endif
