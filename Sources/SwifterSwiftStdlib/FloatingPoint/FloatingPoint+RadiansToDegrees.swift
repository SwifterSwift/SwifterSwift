// FloatingPoint+RadiansToDegrees.swift - Copyright 2026 SwifterSwift

public extension FloatingPoint {
    /// SwifterSwift: The value, in radians, converted to degrees.
    ///
    /// The value is divided by π before it's multiplied by 180, so `.pi / 6` gives exactly `30` rather than
    /// `29.999999999999996`, and large values don't overflow to infinity in the middle of the computation. NaN stays
    /// NaN and infinity stays infinity.
    ///
    /// ```swift
    /// Double.pi.radiansToDegrees  // 180.0
    /// (Double.pi / 6).radiansToDegrees  // 30.0
    /// 1.0.radiansToDegrees  // 57.29577951308232
    /// ```
    ///
    /// Foundation's `Measurement<UnitAngle>` does the same conversion with units attached, and Spatial's `Angle2D`
    /// offers `Angle2D(radians:).degrees`; this property avoids both dependencies.
    var radiansToDegrees: Self {
        self / .pi * 180
    }
}
