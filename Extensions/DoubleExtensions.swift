//
//  DoubleExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Double {

    // tested
    /// Return absolute of double value (read-only).
    public var abs: Double {
        return Swift.abs(self)
    }

    // tested
    /// Return floor of double value (read-only).
    public var floor: Double {
        return Foundation.floor(self)
    }

    // tested
    /// Return ceil of double value (read-only).
    public var ceil: Double {
        return Foundation.ceil(self)
    }

    /// Return random double value between two double values.
    public static func randomBetween(min: Double, max: Double) -> Double {
        let delta = max - min
        return min + Double(arc4random_uniform(UInt32(delta)))
    }

    // FIXME:
    public var degreesToRadians: Double {
        return Double(M_PI) * self / 180.0
    }

    // FIXME:
    public var radiansToDegrees: Double {
        return self * 180 / Double(M_PI)
    }
}

// FIXME:
prefix operator √
public prefix func √ (number: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(number)
}

// FIXME:
infix operator ^
public func ^ (left: Double, right: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(left, right)
}

// FIXME:
infix operator ±
public func ± (left: Double, right: Double) -> (Double, Double) {
    // http://nshipster.com/swift-operators/
    return (left + right, left - right)
}

// FIXME:
prefix operator ±
public prefix func ± (value: Double) -> (Double, Double) {
    // http://nshipster.com/swift-operators/
    return 0 ± value
}
