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
    /// - Warning: This implementation suffers the same issues as `BinaryInteger.random(lowerBound:upperBound:)`
    public static func random(lowerBound: Self, upperBound: Self) -> Self {
        assert(lowerBound < upperBound)
        let distance = lowerBound.distance(to: upperBound)
        return lowerBound.advanced(by: Self.Stride.random(upperBound: distance))
    }
}
