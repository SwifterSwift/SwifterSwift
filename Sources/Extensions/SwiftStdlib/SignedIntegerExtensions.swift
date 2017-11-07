//
//  SignedIntegerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/15/17.
//  Copyright © 2017 SwifterSwift
//

// MARK: - Properties
public extension SignedInteger {
	
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
	
	/// SwifterSwift: Check if integer is even.
	public var isEven: Bool {
		return (self % 2) == 0
	}
	
	/// SwifterSwift: Check if integer is odd.
	public var isOdd: Bool {
		return (self % 2) != 0
	}
	
	/// SwifterSwift: Array of digits of integer value.
	public var digits: [Self] {
		let intsArray = description.flatMap({Int(String($0))})
		return intsArray.map({Self($0)})
	}
	
	/// SwifterSwift: Number of digits of integer value.
	public var digitsCount: Int {
		return description.flatMap({Int(String($0))}).count
	}
	
	/// SwifterSwift: String of format (XXh XXm) from seconds Int.
	public var timeString: String {
		guard self > 0 else {
			return "0 sec"
		}
		if self < 60 {
			return "\(self) sec"
		}
		if self < 3600 {
			return "\(self / 60) min"
		}
		let hours = self / 3600
		let mins = (self % 3600) / 60
		
		if hours != 0 && mins == 0 {
			return "\(hours)h"
		}
		return "\(hours)h \(mins)m"
	}

}

// MARK: - Methods
public extension SignedInteger {
	
	/// SwifterSwift: Greatest common divisor of integer value and n.
	///
	/// - Parameter n: integer value to find gcd with.
	/// - Returns: greatest common divisor of self and n.
	public func gcd(of n: Self) -> Self {
		return n == 0 ? self : n.gcd(of: self % n)
	}
	
	/// SwifterSwift: Least common multiple of integer and n.
	///
	/// - Parameter n: integer value to find lcm with.
	/// - Returns: least common multiple of self and n.
	public func lcm(of n: Self) -> Self {
		return (self * n).abs / gcd(of: n)
	}
	
}
