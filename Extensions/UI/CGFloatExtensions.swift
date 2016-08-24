//
//  CGFloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension CGFloat {

    /// Return absolute of CGFloat value.
    public var abs: CGFloat {
        return Swift.abs(self)
    }

    /// Return floor of CGFloat value.
    public var floor: CGFloat {
        return Foundation.floor(self)
    }

    /// Return ceil of CGFloat value.
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }

    /// Return random CGFloat value between two CGFloat values.
    public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
        let delta = max - min
        return min + CGFloat(arc4random_uniform(UInt32(delta)))
    }

    /// Return degree value of radian input.
    public var degreesToRadians: CGFloat {
        return CGFloat(M_PI) * self / 180.0
    }

    /// Return radian value of degree input.
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat(M_PI)
    }
}

/// Return square root of value.
prefix operator √
public prefix func √ (number: CGFloat) -> CGFloat {
    // http://nshipster.com/swift-operators/
    return sqrt(number)
}

/// Return value of exponentiation.
infix operator ^
public func ^ (left: CGFloat, right: CGFloat) -> CGFloat {
    // http://nshipster.com/swift-operators/
    return pow(left, right)
}

/// Return tuple of plus-minus operation.
infix operator ±
public func ± (left: CGFloat, right: CGFloat) -> (CGFloat, CGFloat) {
    // http://nshipster.com/swift-operators/
    return (left + right, left - right)
}

/// Return tuple of plus-minus operation.
prefix operator ±
public prefix func ± (value: CGFloat) -> (CGFloat, CGFloat) {
    // http://nshipster.com/swift-operators/
    return 0 ± value
}
