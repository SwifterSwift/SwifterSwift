//
//  CGFloatExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    /// Return absolute of CGFloat value (read-only).
    public var abs: CGFloat {
        return Swift.abs(self)
    }
    
    /// Return floor of CGFloat value (read-only).
    public var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// Return ceil of CGFloat value (read-only).
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// Return random CGFloat value between two CGFloat values.
    public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
        let delta = max - min
        return min + CGFloat(arc4random_uniform(UInt32(delta)))
    }
    
    // FIXME:
    public var degreesToRadians: CGFloat {
        return CGFloat(M_PI) * self / 180.0
    }
    
    // FIXME:
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat(M_PI)
    }
}

// FIXME:
prefix operator √
public prefix func √ (number: CGFloat) -> CGFloat {
    // http://nshipster.com/swift-operators/
    return sqrt(number)
}

// FIXME:
infix operator **
public func ** (left: CGFloat, right: CGFloat) -> CGFloat {
    // http://nshipster.com/swift-operators/
    return pow(left, right)
}

// FIXME:
infix operator ±
public func ± (left: CGFloat, right: CGFloat) -> (CGFloat, CGFloat) {
    // http://nshipster.com/swift-operators/
    return (left + right, left - right)
}

// FIXME:
prefix operator ±
public prefix func ± (value: CGFloat) -> (CGFloat, CGFloat) {
    // http://nshipster.com/swift-operators/
    return 0 ± value
}
