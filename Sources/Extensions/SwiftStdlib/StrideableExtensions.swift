//
//  StrideableExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

public extension Strideable where Stride: BinaryInteger {
	/// SwifterSwift: Generate a random integer within a given `Strideable` range.
	///
	/// - Parameters:
	///   - lowerBound: The lower bound of the integer-`Strideable` range.
	///   - upperBound: The upper bound of the integer-`Strideable` range.
	/// - Returns: An integer between `lowerBound` and `upperBound` (exclusive).
	public static func random(lowerBound: Self, upperBound: Self) -> Self {
		let distance = lowerBound.distance(to: upperBound)
		return lowerBound.advanced(by: numericCast(arc4random_uniform(numericCast(distance))))
	}
}
