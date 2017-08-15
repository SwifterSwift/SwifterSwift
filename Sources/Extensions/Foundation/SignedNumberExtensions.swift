//
//  SignedNumberExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/15/17.
//
//

import Foundation


public extension SignedNumber {
	
	/// SwifterSwift: Absolute value of integer.
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
	
	/// SwifterSwift: String.
	public var string: String {
		return String(describing: self)
	}
	
	/// SwifterSwift: String with number and current locale currency.
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as! NSNumber)!
	}
}

