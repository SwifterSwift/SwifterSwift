//
//  SignedIntegerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/15/17.
//
//

import Foundation


// MARK: - Properties
public extension SignedInteger {
	
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
		var digits: [Self] = []
		for char in String(self).characters {
			if let int = IntMax(String(char)) {
				digits.append(Self(int))
			}
		}
		return digits
	}
	
	/// SwifterSwift: Number of digits of integer value.
	public var digitsCount: Int {
		return String(self).characters.count
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


