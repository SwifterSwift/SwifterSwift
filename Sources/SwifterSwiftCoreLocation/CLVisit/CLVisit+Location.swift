// CLVisit+Location.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation) && !os(tvOS) && !os(watchOS) && !os(visionOS)
import CoreLocation
import Foundation

public extension CLVisit {
    /// SwifterSwift: The visit as a location, with its coordinate, accuracy and time.
    ///
    /// The location's coordinate and `horizontalAccuracy` are the visit's, so the accuracy is the radius of the
    /// visited region. A visit has no altitude, so `altitude` is 0 and `verticalAccuracy` is -1, which marks the
    /// altitude as invalid.
    ///
    /// The timestamp is the visit's `arrivalDate`. When the arrival wasn't observed and `arrivalDate` is
    /// `Date.distantPast`, it's the `departureDate` instead.
    ///
    /// ```swift
    /// func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    ///     let place = visit.location
    ///     place.coordinate  // visit.coordinate
    ///     place.horizontalAccuracy  // visit.horizontalAccuracy
    ///     place.timestamp  // visit.arrivalDate
    /// }
    /// ```
    var location: CLLocation {
        CLLocation(
            coordinate: coordinate,
            altitude: 0,
            horizontalAccuracy: horizontalAccuracy,
            verticalAccuracy: -1,
            timestamp: arrivalDate == .distantPast ? departureDate : arrivalDate
        )
    }
}
#endif
