// MKMapView+Zoom.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import CoreLocation
import MapKit
#if canImport(UIKit)
import UIKit
#else
import Foundation
#endif

public extension MKMapView {
    #if canImport(UIKit)
    /// SwifterSwift: Changes the visible area of the map so it shows all of the given coordinates.
    ///
    /// The map shows the smallest rectangle that contains every coordinate, plus `edgePadding`. The area is at least
    /// `meters` wide and tall, so a single coordinate, or coordinates that are very close together, are shown with
    /// some of their surroundings instead of at the deepest zoom level. Like
    /// `setVisibleMapRect(_:edgePadding:animated:)`, the map adjusts the area to its own aspect ratio, so it may show
    /// more than requested.
    ///
    /// Invalid coordinates (see `CLLocationCoordinate2DIsValid(_:)`) are ignored, and if there are no valid coordinates
    /// the map doesn't change. If `meters` isn't a positive, finite distance there's no minimum size, and a single
    /// coordinate is only centered without changing the zoom level. The rectangle is computed on the flat map, so
    /// coordinates on both sides of the antimeridian make the map show the whole width of the world.
    ///
    /// ```swift
    /// let stops = [
    ///     CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243),
    ///     CLLocationCoordinate2D(latitude: 37.0662, longitude: 37.3833)
    /// ]
    /// let padding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    /// mapView.zoom(to: stops, meters: 500, edgePadding: padding, animated: true)
    /// mapView.zoom(to: [stops[0]], meters: 500, animated: false)  // shows about 500 m around the first stop
    /// ```
    ///
    /// - Parameters:
    ///   - coordinates: The coordinates to show.
    ///   - meters: The minimum width and height of the visible area, in meters.
    ///   - edgePadding: The extra space, in points, to keep around the coordinates. The default is no padding.
    ///   - animated: `true` to animate the change; `false` to change the visible area immediately.
    /// - Complexity: O(*n*), where *n* is the number of coordinates.
    func zoom(
        to coordinates: [CLLocationCoordinate2D],
        meters: CLLocationDistance,
        edgePadding: UIEdgeInsets = .zero,
        animated: Bool
    ) {
        var rect = MKMapRect.null
        for coordinate in coordinates where CLLocationCoordinate2DIsValid(coordinate) {
            rect = rect.union(MKMapRect(origin: MKMapPoint(coordinate), size: MKMapSize(width: 0, height: 0)))
        }
        guard !rect.isNull else { return }

        let center = MKMapPoint(x: rect.midX, y: rect.midY)
        let side = meters * MKMapPointsPerMeterAtLatitude(center.coordinate.latitude)
        if side.isFinite, side > 0 {
            // Grow each side that's shorter than `meters`, around the same center.
            rect = rect.insetBy(dx: min(rect.width - side, 0) / 2, dy: min(rect.height - side, 0) / 2)
        }

        if rect.width == 0, rect.height == 0 {
            setCenter(center.coordinate, animated: animated)
        } else {
            setVisibleMapRect(rect, edgePadding: edgePadding, animated: animated)
        }
    }
    #else
    /// SwifterSwift: Changes the visible area of the map so it shows all of the given coordinates.
    ///
    /// The map shows the smallest rectangle that contains every coordinate, plus `edgePadding`. The area is at least
    /// `meters` wide and tall, so a single coordinate, or coordinates that are very close together, are shown with
    /// some of their surroundings instead of at the deepest zoom level. Like
    /// `setVisibleMapRect(_:edgePadding:animated:)`, the map adjusts the area to its own aspect ratio, so it may show
    /// more than requested.
    ///
    /// Invalid coordinates (see `CLLocationCoordinate2DIsValid(_:)`) are ignored, and if there are no valid coordinates
    /// the map doesn't change. If `meters` isn't a positive, finite distance there's no minimum size, and a single
    /// coordinate is only centered without changing the zoom level. The rectangle is computed on the flat map, so
    /// coordinates on both sides of the antimeridian make the map show the whole width of the world.
    ///
    /// ```swift
    /// let stops = [
    ///     CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243),
    ///     CLLocationCoordinate2D(latitude: 37.0662, longitude: 37.3833)
    /// ]
    /// let padding = NSEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    /// mapView.zoom(to: stops, meters: 500, edgePadding: padding, animated: true)
    /// mapView.zoom(to: [stops[0]], meters: 500, animated: false)  // shows about 500 m around the first stop
    /// ```
    ///
    /// - Parameters:
    ///   - coordinates: The coordinates to show.
    ///   - meters: The minimum width and height of the visible area, in meters.
    ///   - edgePadding: The extra space, in points, to keep around the coordinates. The default is no padding.
    ///   - animated: `true` to animate the change; `false` to change the visible area immediately.
    /// - Complexity: O(*n*), where *n* is the number of coordinates.
    func zoom(
        to coordinates: [CLLocationCoordinate2D],
        meters: CLLocationDistance,
        edgePadding: NSEdgeInsets = NSEdgeInsets(),
        animated: Bool
    ) {
        var rect = MKMapRect.null
        for coordinate in coordinates where CLLocationCoordinate2DIsValid(coordinate) {
            rect = rect.union(MKMapRect(origin: MKMapPoint(coordinate), size: MKMapSize(width: 0, height: 0)))
        }
        guard !rect.isNull else { return }

        let center = MKMapPoint(x: rect.midX, y: rect.midY)
        let side = meters * MKMapPointsPerMeterAtLatitude(center.coordinate.latitude)
        if side.isFinite, side > 0 {
            // Grow each side that's shorter than `meters`, around the same center.
            rect = rect.insetBy(dx: min(rect.width - side, 0) / 2, dy: min(rect.height - side, 0) / 2)
        }

        if rect.width == 0, rect.height == 0 {
            setCenter(center.coordinate, animated: animated)
        } else {
            setVisibleMapRect(rect, edgePadding: edgePadding, animated: animated)
        }
    }
    #endif
}
#endif
