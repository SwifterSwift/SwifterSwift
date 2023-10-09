// MeasurementExtensions.swift - Copyright 2023 SwifterSwift

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

#endif
