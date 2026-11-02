// Measurement+Radians.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Measurement where UnitType == UnitAngle {
    /// SwifterSwift: Returns an angle of the given number of radians.
    ///
    /// A shorter spelling of `Measurement(value: value, unit: UnitAngle.radians)` that reads well wherever a
    /// `Measurement<UnitAngle>` is expected, such as `image.rotated(by: .radians(.pi / 2))`. The value is kept as given:
    /// it isn't wrapped into `0..<2π`, and negative, NaN and infinite values stay as they are. Use
    /// `converted(to: .degrees)` to get the angle in degrees.
    ///
    /// ```swift
    /// let angle: Measurement<UnitAngle> = .radians(.pi)
    /// angle.value  // 3.141592653589793
    /// angle.converted(to: .degrees).value  // 180
    /// ```
    ///
    /// - Parameter value: The size of the angle, in radians.
    /// - Returns: A measurement of `value` radians.
    static func radians(_ value: Double) -> Measurement<UnitAngle> {
        Measurement(value: value, unit: .radians)
    }
}
#endif
