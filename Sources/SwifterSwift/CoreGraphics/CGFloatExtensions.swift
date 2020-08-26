// CGFloatExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties

public extension CGFloat {
    /// SwifterSwift: Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(self)
    }

    #if canImport(Foundation)
    /// SwifterSwift: Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    #endif

    /// SwifterSwift: Radian value of degree input.
    var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }

    #if canImport(Foundation)
    /// SwifterSwift: Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    #endif

    /// SwifterSwift: Check if CGFloat is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// SwifterSwift: Check if CGFloat is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// SwifterSwift: Int.
    var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Float.
    var float: Float {
        return Float(self)
    }

    /// SwifterSwift: Double.
    var double: Double {
        return Double(self)
    }

    /// SwifterSwift: Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
}

#endif
