//
//  MKPolylineExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 3/8/18.
//  Copyright © 2018 SwifterSwift
//

#if !os(watchOS)

import MapKit

@available(tvOS 9.2, *)
public extension MKPolyline {

    /// SwifterSwift: Return an Array of coordinates representing the provided polyline.
    public var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid,
                                              count: pointCount)

        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))

        return coords
    }
}

#endif
