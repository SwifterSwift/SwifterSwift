//
//  FloatingPointExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 7/23/17.
//  Copyright © 2017 SwifterSwift
//

// MARK: - Properties
public extension FloatingPoint {

	/// SwifterSwift: Absolute value of integer number.
	public var abs: Self {
		return Swift.abs(self)
	}

	/// SwifterSwift: Check if integer is positive.
	public var isPositive: Bool {
		return self > 0
	}

	/// SwifterSwift: Check if integer is negative.
	public var isNegative: Bool {
		return self < 0
	}

	/// SwifterSwift: Ceil of number.
	public var ceil: Self {
		return Foundation.ceil(self)
	}

	/// SwifterSwift: Radian value of degree input.
	public var degreesToRadians: Self {
		return Self.pi * self / Self(180)
	}

	/// SwifterSwift: Floor of number.
	public var floor: Self {
		return Foundation.floor(self)
	}

	/// SwifterSwift: Degree value of radian input.
	public var radiansToDegrees: Self {
		return self * Self(180) / Self.pi
	}

}

// MARK: - Methods
public extension FloatingPoint {

	/// SwifterSwift: Random number between two number.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random number between two numbers.
	public static func random(between min: Self, and max: Self) -> Self {
		let aMin = Self.minimum(min, max)
		let aMax = Self.maximum(min, max)
		let delta = aMax - aMin
		return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
	}

	/// SwifterSwift: Random number in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	/// - Returns: random number in the given closed range.
	public static func random(inRange range: ClosedRange<Self>) -> Self {
		let delta = range.upperBound - range.lowerBound
		return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
	}

}

// MARK: - Initializers
public extension FloatingPoint {

	/// SwifterSwift: Created a random number between two numbers.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	public init(randomBetween min: Self, and max: Self) {
		let aMin = Self.minimum(min, max)
		let aMax = Self.maximum(min, max)
		let delta = aMax - aMin
		self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
	}

	/// SwifterSwift: Create a random number in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public init(randomInRange range: ClosedRange<Self>) {
		let delta = range.upperBound - range.lowerBound
		self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
	}

}

// MARK: - Operators

// swiftlint:disable identifier_name
infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: number
///   - rhs: number
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
public func ±<T: FloatingPoint> (lhs: T, rhs: T) -> (T, T) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}
// swiftlint:enable identifier_name

// swiftlint:disable identifier_name
prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: number
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ±<T: FloatingPoint> (number: T) -> (T, T) {
	// http://nshipster.com/swift-operators/
	return 0 ± number
}
// swiftlint:enable identifier_name
