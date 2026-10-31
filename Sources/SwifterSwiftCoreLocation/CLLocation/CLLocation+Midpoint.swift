// CLLocation+Midpoint.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation

public extension CLLocation {
    /// SwifterSwift: Returns the halfway point along the great-circle path between this location and another.
    ///
    /// The great-circle path is the shortest path over the surface of the Earth, so the midpoint of two places at the
    /// same latitude is generally a bit closer to the pole than that latitude, and the path between two places on
    /// either side of the antimeridian crosses it rather than going around the world. The returned longitude is
    /// always in the range -180...180.
    ///
    /// The returned location carries only a coordinate, like one created with `CLLocation(latitude:longitude:)`:
    /// altitude, course, speed and accuracy aren't taken from either location, and its timestamp is the time it was
    /// created. For two antipodal points, every point on a whole great circle is halfway between them, and the result
    /// is one of those points.
    ///
    /// ```swift
    /// let paris = CLLocation(latitude: 48.8566, longitude: 2.3522)
    /// let newYork = CLLocation(latitude: 40.7128, longitude: -74.0060)
    /// paris.midpoint(to: newYork)?.coordinate  // (51.58, -39.01)
    ///
    /// let fiji = CLLocation(latitude: -17, longitude: 179)
    /// let samoa = CLLocation(latitude: -14, longitude: -172)
    /// fiji.midpoint(to: samoa)?.coordinate  // (-15.55, -176.47)
    ///
    /// let invalid = CLLocation(latitude: 100, longitude: 0)
    /// paris.midpoint(to: invalid)  // nil
    /// ```
    ///
    /// - Parameter location: The other end of the path.
    /// - Returns: The location halfway between the two locations, or `nil` if either coordinate isn't valid (see
    ///   `CLLocationCoordinate2DIsValid(_:)`).
    func midpoint(to location: CLLocation) -> CLLocation? {
        guard CLLocationCoordinate2DIsValid(coordinate), CLLocationCoordinate2DIsValid(location.coordinate) else {
            return nil
        }

        // Formula from https://www.movable-type.co.uk/scripts/latlong.html, with φ for latitudes and λ for longitudes:
        //   Bx = cos φ2 ⋅ cos Δλ
        //   By = cos φ2 ⋅ sin Δλ
        //   φm = atan2(sin φ1 + sin φ2, √((cos φ1 + Bx)² + By²))
        //   λm = λ1 + atan2(By, cos φ1 + Bx)
        let latitude1 = coordinate.latitude * .pi / 180
        let longitude1 = coordinate.longitude * .pi / 180
        let latitude2 = location.coordinate.latitude * .pi / 180
        let deltaLongitude = (location.coordinate.longitude - coordinate.longitude) * .pi / 180

        let bx = cos(latitude2) * cos(deltaLongitude)
        let by = cos(latitude2) * sin(deltaLongitude)
        let latitude = atan2(
            sin(latitude1) + sin(latitude2),
            ((cos(latitude1) + bx) * (cos(latitude1) + bx) + by * by).squareRoot()
        )
        let longitude = longitude1 + atan2(by, cos(latitude1) + bx)

        // Bring the longitude back into -180...180 when the path crosses the antimeridian.
        let degrees = (longitude * 180 / .pi + 540).truncatingRemainder(dividingBy: 360) - 180
        return CLLocation(latitude: latitude * 180 / .pi, longitude: degrees)
    }
}
#endif
