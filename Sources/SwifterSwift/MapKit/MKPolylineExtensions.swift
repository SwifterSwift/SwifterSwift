//
//  MKPolylineExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 3/8/18.
//  Copyright © 2018 SwifterSwift
//

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

// MARK: - Properties
@available(tvOS 9.2, *)
public extension MKPolyline {

    /// SwifterSwift: Return an Array of coordinates representing the provided polyline.
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }

}

#endif
