// MKPolylineExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(MapKit)
import MapKit

import struct CoreLocation.CLLocationCoordinate2D

final class MKPolylineExtensionsTests: XCTestCase {
    let coordinates = [
        (37.330514, -121.888863),
        (37.330832, -121.888337),
        (37.329599, -121.886859),
        (37.330019, -121.885993),
        (37.329767, -121.885813)
    ].map(CLLocationCoordinate2D.init)

    func testInitWithCoordinates() {
        var refCoordinates = coordinates

        let polyline = MKPolyline(coordinates: coordinates)
        let polyline2 = MKPolyline(coordinates: &refCoordinates, count: refCoordinates.count)

        for (coordinate1, coordinate2) in zip(polyline.coordinates, polyline2.coordinates) {
            XCTAssertEqual(coordinate1.latitude, coordinate2.latitude, accuracy: 0.000000001)
            XCTAssertEqual(coordinate1.longitude, coordinate2.longitude, accuracy: 0.000000001)
        }
    }
}

#endif
