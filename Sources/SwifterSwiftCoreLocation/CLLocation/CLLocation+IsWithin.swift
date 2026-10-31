// CLLocation+IsWithin.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation

public extension CLLocation {
    /// SwifterSwift: Returns whether another location is within the given distance of this one.
    ///
    /// The distance between the two locations is measured with `CLLocation.distance(from:)`, which follows the
    /// curvature of the Earth and ignores altitude. A location exactly `distance` away counts as within it. Accuracy
    /// isn't taken into account; to allow for it, add the locations' `horizontalAccuracy` to `distance`.
    ///
    /// The result is `false` if either coordinate isn't valid (see `CLLocationCoordinate2DIsValid(_:)`), or if
    /// `distance` is negative or NaN.
    ///
    /// ```swift
    /// let gate = CLLocation(latitude: 37.575803, longitude: 126.976807)
    /// let visitor = CLLocation(latitude: 37.572931, longitude: 126.976834)
    /// gate.isWithin(Measurement(value: 320, unit: .meters), of: visitor)  // true
    /// gate.isWithin(Measurement(value: 300, unit: .meters), of: visitor)  // false
    /// gate.isWithin(Measurement(value: 0.2, unit: .miles), of: visitor)  // true
    /// ```
    ///
    /// - Parameters:
    ///   - distance: The greatest distance at which `location` still counts as within range.
    ///   - location: The location to measure the distance to.
    /// - Returns: `true` if `location` is at most `distance` away from this location; otherwise, `false`.
    func isWithin(_ distance: Measurement<UnitLength>, of location: CLLocation) -> Bool {
        guard CLLocationCoordinate2DIsValid(coordinate), CLLocationCoordinate2DIsValid(location.coordinate) else {
            return false
        }
        return self.distance(from: location) <= distance.converted(to: .meters).value
    }
}
#endif
