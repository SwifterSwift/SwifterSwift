//
//  BinaryFloatingPointExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

public extension BinaryFloatingPoint {

    /// SwifterSwift: Generate a random floating point number within a given range.
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound of the floating point range. Defaults to 0.0.
    ///   - upperBound: The upper bound of the floating point range. Defaults to 1.0.
    /// - Returns: A floating point between `lowerBound` and `upperBound` (inclusive).
    /// - Warning: If `upperBound - lowerBound` has a non-normal value (e.g. `infinity` or `nan`) the result is undefined.
    public static func random(lowerBound: Self = 0.0, upperBound: Self = 1.0) -> Self {
        assert(lowerBound <= upperBound)
        let distance = upperBound - lowerBound
        assert(!distance.isSubnormal)
        return lowerBound + (Self(drand48()) * distance)
    }

}
