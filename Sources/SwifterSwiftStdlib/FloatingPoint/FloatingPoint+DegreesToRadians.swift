// FloatingPoint+DegreesToRadians.swift - Copyright 2026 SwifterSwift

public extension FloatingPoint {
    /// SwifterSwift: The value, in degrees, converted to radians.
    ///
    /// The value is divided by 180 before it's multiplied by π, so even `greatestFiniteMagnitude` converts without
    /// overflowing to infinity, and the multiples of 45° give exactly `.pi / 4`, `.pi / 2`, `.pi` and so on. NaN
    /// stays NaN and infinity stays infinity.
    ///
    /// ```swift
    /// 180.0.degreesToRadians  // 3.141592653589793
    /// 90.0.degreesToRadians  // 1.5707963267948966
    /// (-45.0).degreesToRadians  // -0.7853981633974483
    /// ```
    ///
    /// Foundation's `Measurement<UnitAngle>` does the same conversion with units attached, and Spatial's `Angle2D`
    /// offers `Angle2D(degrees:).radians`; this property avoids both dependencies.
    var degreesToRadians: Self {
        self / 180 * .pi
    }
}
