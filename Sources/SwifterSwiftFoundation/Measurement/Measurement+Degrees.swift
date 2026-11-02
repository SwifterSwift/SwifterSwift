// Measurement+Degrees.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Measurement where UnitType == UnitAngle {
    /// SwifterSwift: Returns an angle of the given number of degrees.
    ///
    /// A shorter spelling of `Measurement(value: value, unit: UnitAngle.degrees)` that reads well wherever a
    /// `Measurement<UnitAngle>` is expected, such as `view.rotate(byAngle: .degrees(90))`. The value is kept as given:
    /// it isn't wrapped into `0..<360`, and negative, NaN and infinite values stay as they are. Use
    /// `converted(to: .radians)` to get the angle in radians.
    ///
    /// ```swift
    /// let angle: Measurement<UnitAngle> = .degrees(90)
    /// angle.value  // 90
    /// angle.converted(to: .radians).value  // 1.5707963267948966
    /// ```
    ///
    /// - Parameter value: The size of the angle, in degrees.
    /// - Returns: A measurement of `value` degrees.
    static func degrees(_ value: Double) -> Measurement<UnitAngle> {
        Measurement(value: value, unit: .degrees)
    }
}
#endif
