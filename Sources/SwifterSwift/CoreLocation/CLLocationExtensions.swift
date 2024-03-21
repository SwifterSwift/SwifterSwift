// CLLocationExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation

// MARK: - Methods

public extension CLLocation {
    /// SwifterSwift: Calculate the half-way point along a great circle path between the two points.
    ///
    /// - Parameters:
    ///   - start: Start location.
    ///   - end: End location.
    /// - Returns: Location that represents the half-way point.
    static func midLocation(start: CLLocation, end: CLLocation) -> CLLocation {
        let lat1 = Double.pi * start.coordinate.latitude / 180.0
        let long1 = Double.pi * start.coordinate.longitude / 180.0
        let lat2 = Double.pi * end.coordinate.latitude / 180.0
        let long2 = Double.pi * end.coordinate.longitude / 180.0

        // Formula
        //    Bx = cos φ2 ⋅ cos Δλ
        //    By = cos φ2 ⋅ sin Δλ
        //    φm = atan2( sin φ1 + sin φ2, √(cos φ1 + Bx)² + By² )
        //    λm = λ1 + atan2(By, cos(φ1)+Bx)
        // Source: http://www.movable-type.co.uk/scripts/latlong.html

        let bxLoc = cos(lat2) * cos(long2 - long1)
        let byLoc = cos(lat2) * sin(long2 - long1)
        let mlat = atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + bxLoc) * (cos(lat1) + bxLoc) + (byLoc * byLoc)))
        let mlong = long1 + atan2(byLoc, cos(lat1) + bxLoc)

        return CLLocation(latitude: mlat * 180 / Double.pi, longitude: mlong * 180 / Double.pi)
    }

    /// SwifterSwift: Calculate the half-way point along a great circle path between self and another points.
    ///
    /// - Parameter point: End location.
    /// - Returns: Location that represents the half-way point.
    func midLocation(to point: CLLocation) -> CLLocation {
        return CLLocation.midLocation(start: self, end: point)
    }

    /// SwifterSwift: Calculates the bearing to another CLLocation.
    ///
    /// - Parameters:
    ///   - destination: Location to calculate bearing.
    /// - Returns: Calculated bearing degrees in the range 0° ... 360°
    func bearing(to destination: CLLocation) -> Double {
        // http://stackoverflow.com/questions/3925942/cllocation-category-for-calculating-bearing-w-haversine-function
        let lat1 = Double.pi * coordinate.latitude / 180.0
        let long1 = Double.pi * coordinate.longitude / 180.0
        let lat2 = Double.pi * destination.coordinate.latitude / 180.0
        let long2 = Double.pi * destination.coordinate.longitude / 180.0

        // Formula: θ = atan2( sin Δλ ⋅ cos φ2 , cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ )
        // Source: http://www.movable-type.co.uk/scripts/latlong.html

        let rads = atan2(
            sin(long2 - long1) * cos(lat2),
            cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(long2 - long1))
        let degrees = rads * 180 / Double.pi

        return (degrees + 360).truncatingRemainder(dividingBy: 360)
    }

    /// SwifterSwift: Check the distance to `location` is less than or equal to `radius`.
    ///
    /// - Parameters:
    ///   - location: End location.
    ///   - radius: Range limit distance.
    ///   - unit: The unit of length. Default value is `.meters`.
    /// - Returns: `true` if the distance between the receiver and `location` is less than or equal to the given
    /// `radius`.
    func isInRange(of location: CLLocation, radius: Double, unitLength unit: UnitLength = .meters) -> Bool {
        let distance = Measurement(value: radius, unit: unit).converted(to: .meters).value
        return self.distance(from: location) <= distance
    }
}

#endif
