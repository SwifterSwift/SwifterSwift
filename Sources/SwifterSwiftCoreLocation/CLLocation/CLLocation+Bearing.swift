// CLLocation+Bearing.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation

public extension CLLocation {
    /// SwifterSwift: Returns the initial bearing from this location to another, in degrees clockwise from true north.
    ///
    /// The bearing is the direction you set off in when you follow the great-circle path, the shortest path over the
    /// surface of the Earth. Along that path the direction changes, so the bearing back from `destination` generally
    /// isn't the opposite of this one. Like `CLLocation.course`, the result is measured from true north: 0 is north, 90
    /// is east, 180 is south and 270 is west. Paths that cross the antimeridian take the short way across it.
    ///
    /// There's no direction from a place to itself, so the bearing between two locations with the same coordinate is
    /// `nil`.
    ///
    /// ```swift
    /// let stLouis = CLLocation(latitude: 38.6319, longitude: -90.2829)
    /// let belleville = CLLocation(latitude: 38.5353, longitude: -89.8448)
    /// stLouis.bearing(to: belleville)  // 105.62
    ///
    /// let fiji = CLLocation(latitude: 0, longitude: 179)
    /// let samoa = CLLocation(latitude: 0, longitude: -179)
    /// fiji.bearing(to: samoa)  // 90.0
    /// fiji.bearing(to: fiji)  // nil
    /// ```
    ///
    /// - Parameter destination: The location to head to.
    /// - Returns: The bearing to `destination`, in degrees in the range `0..<360`, or `nil` if either coordinate isn't
    ///   valid (see `CLLocationCoordinate2DIsValid(_:)`) or both locations have the same coordinate.
    func bearing(to destination: CLLocation) -> CLLocationDirection? {
        let start = coordinate
        let end = destination.coordinate
        guard
            CLLocationCoordinate2DIsValid(start),
            CLLocationCoordinate2DIsValid(end),
            start.latitude != end.latitude || start.longitude != end.longitude
        else {
            return nil
        }

        // Formula from https://www.movable-type.co.uk/scripts/latlong.html, with φ for latitudes and λ for longitudes:
        //   θ = atan2(sin Δλ ⋅ cos φ2, cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ)
        let latitude1 = start.latitude * .pi / 180
        let latitude2 = end.latitude * .pi / 180
        let deltaLongitude = (end.longitude - start.longitude) * .pi / 180

        let radians = atan2(
            sin(deltaLongitude) * cos(latitude2),
            cos(latitude1) * sin(latitude2) - sin(latitude1) * cos(latitude2) * cos(deltaLongitude)
        )
        return (radians * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
    }
}
#endif
