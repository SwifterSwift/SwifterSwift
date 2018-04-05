//
//  IntExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension Int {

	/// SwifterSwift: CountableRange 0..<Int.
	public var countableRange: CountableRange<Int> {
		return 0..<self
	}

	/// SwifterSwift: Radian value of degree input.
	public var degreesToRadians: Double {
		return Double.pi * Double(self) / 180.0
	}

	/// SwifterSwift: Degree value of radian input
	public var radiansToDegrees: Double {
		return Double(self) * 180 / Double.pi
	}

	/// SwifterSwift: UInt.
	public var uInt: UInt {
		return UInt(self)
	}

	/// SwifterSwift: Double.
	public var double: Double {
		return Double(self)
	}

	/// SwifterSwift: Float.
	public var float: Float {
		return Float(self)
	}

	#if canImport(CoreGraphics)
	/// SwifterSwift: CGFloat.
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
	#endif

	/// SwifterSwift: String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
	public var kFormatted: String {
		var sign: String {
			return self >= 0 ? "" : "-"
		}
		let abs = Swift.abs(self)
		if abs == 0 {
			return "0k"
		} else if abs >= 0 && abs < 1000 {
			return "0k"
		} else if abs >= 1000 && abs < 1000000 {
			return String(format: "\(sign)%ik", abs / 1000)
		}
		return String(format: "\(sign)%ikk", abs / 100000)
	}

	/// SwifterSwift: Array of digits of integer value.
	public var digits: [Int] {
		guard self != 0 else { return [0] }
		var digits = [Int]()
		var number = self.abs

		while number != 0 {
			let xNumber = number % 10
			digits.append(xNumber)
			number /= 10
		}

		digits.reverse()
		return digits
	}

	/// SwifterSwift: Number of digits of integer value.
	public var digitsCount: Int {
		guard self != 0 else { return 1 }
		let number = Double(self.abs)
		return Int(log10(number) + 1)
	}

}

// MARK: - Methods
public extension Int {

	/// SwifterSwift: Random integer between two integer values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random double between two double values.
	public static func random(between min: Int, and max: Int) -> Int {
		return random(inRange: min...max)
	}

	/// SwifterSwift: Random integer in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	/// - Returns: random double in the given closed range.
	public static func random(inRange range: ClosedRange<Int>) -> Int {
		let delta = UInt32(range.upperBound - range.lowerBound + 1)
		return range.lowerBound + Int(arc4random_uniform(delta))
	}

	/// SwifterSwift: check if given integer prime or not.
	/// Warning: Using big numbers can be computationally expensive!
	/// - Returns: true or false depending on prime-ness
	public func isPrime() -> Bool {
		// To improve speed on latter loop :)
		if self == 2 {
			return true
		}

		guard self > 1 && self % 2 != 0 else {
			return false
		}
		// Explanation: It is enough to check numbers until
		// the square root of that number. If you go up from N by one,
		// other multiplier will go 1 down to get similar result
		// (integer-wise operation) such way increases speed of operation
		let base = Int(sqrt(Double(self)))
		for int in Swift.stride(from: 3, through: base, by: 2) where self % int == 0 {
			return false
		}
		return true
	}

	/// SwifterSwift: Roman numeral string from integer (if applicable).
	///
	///10.romanNumeral() -> "X"
	///
	/// - Returns: The roman numeral string.
	public func romanNumeral() -> String? {
		// https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
		guard self > 0 else { // there is no roman numerals for 0 or negative numbers
			return nil
		}
		let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
		let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

		var romanValue = ""
		var startingValue = self

		for (index, romanChar) in romanValues.enumerated() {
			let arabicValue = arabicValues[index]
			let div = startingValue / arabicValue
			if div > 0 {
				for _ in 0..<div {
					romanValue += romanChar
				}
				startingValue -= arabicValue * div
			}
		}
		return romanValue
	}

	// swiftlint:disable identifier_name
	/// SwifterSwift: Rounds to the closest multiple of n
	public func roundToNearest(_ n: Int) -> Int {
		return n == 0 ? self : Int(round(Double(self) / Double(n))) * n
	}
	// swiftlint:enable identifier_name

}

// MARK: - Initializers
public extension Int {

	/// SwifterSwift: Created a random integer between two integer values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	public init(randomBetween min: Int, and max: Int) {
		self = Int.random(between: min, and: max)
	}

	/// SwifterSwift: Create a random integer in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public init(randomInRange range: ClosedRange<Int>) {
		self = Int.random(inRange: range)
	}

}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ** 3 = 8).
public func ** (lhs: Int, rhs: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(Double(lhs), Double(rhs))
}

// swiftlint:disable identifier_name
prefix operator √
/// SwifterSwift: Square root of integer.
///
/// - Parameter int: integer value to find square root for
/// - Returns: square root of given integer.
public prefix func √ (int: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(Double(int))
}
// swiftlint:enable identifier_name

// swiftlint:disable identifier_name
infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: integer number.
///   - rhs: integer number.
/// - Returns: tuple of plus-minus operation (example: 2 ± 3 -> (5, -1)).
public func ± (lhs: Int, rhs: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}
// swiftlint:enable identifier_name

// swiftlint:disable identifier_name
prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: integer number
/// - Returns: tuple of plus-minus operation (example: ± 2 -> (2, -2)).
public prefix func ± (int: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return 0 ± int
}
// swiftlint:enable identifier_name
