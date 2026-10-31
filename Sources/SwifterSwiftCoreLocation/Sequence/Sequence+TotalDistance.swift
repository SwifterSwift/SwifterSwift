// Sequence+TotalDistance.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation

public extension Sequence where Element: CLLocation {
    /// SwifterSwift: The length of the path that goes through the locations in order.
    ///
    /// The path is the sum of the distances between consecutive locations, each measured with
    /// `CLLocation.distance(from:)`, which follows the curvature of the Earth and ignores altitude. A sequence with
    /// fewer than two locations has a total distance of zero.
    ///
    /// Locations whose coordinate isn't valid (see `CLLocationCoordinate2DIsValid(_:)`), such as GPS fixes without a
    /// position, are skipped, so the path goes straight from the previous valid location to the next one.
    ///
    /// ```swift
    /// let track = [
    ///     CLLocation(latitude: 41, longitude: -111),
    ///     CLLocation(latitude: 41, longitude: -112),
    ///     CLLocation(latitude: 41, longitude: -113),
    /// ]
    /// track.totalDistance(in: .kilometers)  // 168.27 km
    /// track.totalDistance()  // 168271.88 m
    /// [CLLocation]().totalDistance()  // 0.0 m
    /// ```
    ///
    /// - Parameter unit: The unit of the returned measurement. The default is meters.
    /// - Returns: The length of the path through the valid locations, in `unit`.
    /// - Complexity: O(*n*), where *n* is the number of locations.
    func totalDistance(in unit: UnitLength = .meters) -> Measurement<UnitLength> {
        var meters: CLLocationDistance = 0
        var previous: CLLocation?
        for location in self where CLLocationCoordinate2DIsValid(location.coordinate) {
            if let previous {
                meters += previous.distance(from: location)
            }
            previous = location
        }
        return Measurement(value: meters, unit: UnitLength.meters).converted(to: unit)
    }
}
#endif
