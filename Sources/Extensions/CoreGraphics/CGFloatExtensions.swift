//
//  CGFloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGFloat {

    /// SwifterSwift: Absolute of CGFloat value.
    public var abs: CGFloat {
        return Swift.abs(self)
    }

    /// SwifterSwift: Ceil of CGFloat value.
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }

    /// SwifterSwift: Radian value of degree input.
    public var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }

    /// SwifterSwift: Floor of CGFloat value.
    public var floor: CGFloat {
        return Foundation.floor(self)
    }

    /// SwifterSwift: Check if CGFloat is positive.
    public var isPositive: Bool {
        return self > 0
    }

    /// SwifterSwift: Check if CGFloat is negative.
    public var isNegative: Bool {
        return self < 0
    }

    /// SwifterSwift: Int.
    public var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Float.
    public var float: Float {
        return Float(self)
    }

    /// SwifterSwift: Double.
    public var double: Double {
        return Double(self)
    }

    /// SwifterSwift: Degree value of radian input.
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }

}
#endif
