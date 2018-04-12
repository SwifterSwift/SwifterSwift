//
//  BinaryIntegerExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

public extension BinaryInteger {
	/// SwifterSwift: Generate a random integer within a given range.
	///
	/// - Parameters:
	///   - lowerBound: The lower bound of the integer range. Defaults to 0.
	///   - upperBound: The upper bound of the integer range.
	/// - Returns: An integer between `lowerBound` and `upperBound` (exclusive).
	public static func random(lowerBound: Self = 0, upperBound: Self) -> Self {
		let distance = Self(lowerBound.distance(to: upperBound))
		return lowerBound + numericCast(arc4random_uniform(numericCast(distance)))
	}
}
