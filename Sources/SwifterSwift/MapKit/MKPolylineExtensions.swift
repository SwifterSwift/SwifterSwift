// MKPolylineExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit

// MARK: - Initializers

@available(tvOS 9.2, *)
public extension MKPolyline {
    /// SwifterSwift: Create a new MKPolyline from a provided Array of coordinates.
    ///
    /// - Parameter coordinates: Array of CLLocationCoordinate2D(s).
    convenience init(coordinates: [CLLocationCoordinate2D]) {
        var refCoordinates = coordinates
        self.init(coordinates: &refCoordinates, count: refCoordinates.count)
    }
}

#endif
