//
//  BinaryFloatingPointExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

extension BinaryFloatingPoint {
	/// SwifterSwift: Generate a random floating point number within a given range.
	///
	/// - Parameters:
	///   - lowerBound: The lower bound of the floating point range. Defaults to 0.0.
	///   - upperBound: The upper bound of the floating point range. Defaults to 1.0.
	/// - Returns: A floating point between `lowerBound` and `upperBound` (inclusive).
	public static func random(lowerBound: Self = 0.0, upperBound: Self = 1.0) -> Self {
		return lowerBound + (Self(drand48()) * (upperBound - lowerBound))
	}
}
