// MeasurementExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(Foundation)
import Foundation

// MARK: - Methods

public extension Measurement where UnitType == UnitAngle {
    /// SwifterSwift:  Create a `Measurement` for an angle with a specified value in degrees.
    /// - Parameter value: The quantity of the angle in degree.
    /// - Returns: Measurement for an angle with unit degrees.
    static func degrees(_ value: Double) -> Measurement {
        return Measurement(value: value, unit: .degrees)
    }

    /// SwifterSwift:  Create a Measurement for an angle with a specified value in arc minutes.
    /// - Parameter value: The quantity of the angle in arc minutes.
    /// - Returns: Measurement for an angle with unit arc minutes.
    static func arcMinutes(_ value: Double) -> Measurement {
        return Measurement(value: value, unit: .arcMinutes)
    }

    /// SwifterSwift:  Create a Measurement for an angle with a specified value in arc seconds.
    /// - Parameter value: The quantity of the angle in arc seconds.
    /// - Returns: Measurement for an angle with unit arc seconds.
    static func arcSeconds(_ value: Double) -> Measurement {
        return Measurement(value: value, unit: .arcSeconds)
    }

    /// SwifterSwift:  Create a Measurement for an angle with a specified value in radians.
    /// - Parameter value: The quantity of the angle in radians.
    /// - Returns: Measurement for an angle with unit radians.
    static func radians(_ value: Double) -> Measurement {
        return Measurement(value: value, unit: .radians)
    }

    /// SwifterSwift:  Create a Measurement for an angle with a specified value in gradians.
    /// - Parameter value: The quantity of the angle in gradians.
    /// - Returns: Measurement for an angle with unit gradians.
    static func gradians(_ value: Double) -> Measurement {
        return Measurement(value: value, unit: .gradians)
    }

    /// SwifterSwift:  Create a Measurement for an angle with a specified value in revolutions.
    /// - Parameter value: The quantity of the angle in revolutions.
    /// - Returns: Measurement for an angle with unit revolutions.
    static func revolutions(_ value: Double) -> Measurement {
        return Measurement(value: value, unit: .revolutions)
    }
}

public extension Measurement {
    /// SwifterSwift: Adds two values and stores the result in the left-hand-side variable.
    /// - Parameters:
    ///   - lhs: The first value to add.
    ///   - rhs: The second value to add.
    static func += (lhs: inout Measurement, rhs: Measurement) {
        lhs = lhs + rhs
    }

    /// SwifterSwift: Subtracts the second value from the first and stores the difference in the left-hand-side
    /// variable.
    /// - Parameters:
    ///   - lhs: A `Measurement` value.
    ///   - rhs: The value to subtract from `lhs`.
    static func -= (lhs: inout Measurement, rhs: Measurement) {
        lhs = lhs - rhs
    }

    /// SwifterSwift: Multiplies two values and stores the result in the left-hand-side variable.
    /// - Parameters:
    ///   - lhs: The first value to multiply.
    ///   - rhs: The second value to multiply.
    static func *= (lhs: inout Measurement, rhs: Double) {
        lhs = lhs * rhs
    }

    /// SwifterSwift: Divides the first value by the second and stores the quotient in the left-hand-side variable.
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
    static func /= (lhs: inout Measurement, rhs: Double) {
        lhs = lhs / rhs
    }
}

#endif
