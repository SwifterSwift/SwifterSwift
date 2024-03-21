// MKMultiPointExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit

// MARK: - Properties

public extension MKMultiPoint {
    /// SwifterSwift: Return an Array of coordinates representing the provided multi point.
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

#endif
