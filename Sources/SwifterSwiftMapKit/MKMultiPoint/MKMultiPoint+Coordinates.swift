// MKMultiPoint+Coordinates.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit)
import CoreLocation
import Foundation
import MapKit

public extension MKMultiPoint {
    /// SwifterSwift: The coordinates of the shape's points, in order.
    ///
    /// This reads every point with `getCoordinates(_:range:)`, so it works for any multipoint shape, such as
    /// `MKPolyline`, `MKPolygon` and `MKGeodesicPolyline`. For a geodesic polyline the result includes the
    /// intermediate points MapKit adds along the curve, not just the coordinates it was created with. A polygon's
    /// coordinates don't include its interior polygons.
    ///
    /// MapKit stores the points as `MKMapPoint`s, so the coordinates are converted back from the map projection: they
    /// can differ from the original coordinates by rounding errors, latitudes beyond about ±85 degrees come back
    /// clamped, and a longitude of 180 can come back as -180, the same meridian.
    ///
    /// ```swift
    /// let route = [
    ///     CLLocationCoordinate2D(latitude: 37.3305, longitude: -121.8889),
    ///     CLLocationCoordinate2D(latitude: 37.3308, longitude: -121.8883)
    /// ]
    /// let polyline = MKPolyline(coordinates: route, count: route.count)
    /// polyline.coordinates  // [(37.3305, -121.8889), (37.3308, -121.8883)]
    /// MKPolyline().coordinates  // []
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of points.
    var coordinates: [CLLocationCoordinate2D] {
        let count = pointCount
        var result = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: count)
        getCoordinates(&result, range: NSRange(location: 0, length: count))
        return result
    }
}
#endif
