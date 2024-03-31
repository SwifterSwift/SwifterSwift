// MKMultiPointExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(MapKit)
import MapKit

import struct CoreLocation.CLLocationCoordinate2D

final class MKMultiPointExtensionsTests: XCTestCase {
    let coordinates = [
        (37.330514, -121.888863),
        (37.330832, -121.888337),
        (37.329599, -121.886859),
        (37.330019, -121.885993),
        (37.329767, -121.885813)
    ].map(CLLocationCoordinate2D.init)

    func testCoordinatesForPolyLine() {
        let polyline = MKPolyline(coordinates: coordinates)

        XCTAssertEqual(coordinates.count, polyline.coordinates.count)

        for (coordinate1, coordinate2) in zip(coordinates, polyline.coordinates) {
            XCTAssertEqual(coordinate1.latitude, coordinate2.latitude, accuracy: 0.000000001)
            XCTAssertEqual(coordinate1.longitude, coordinate2.longitude, accuracy: 0.000000001)
        }
    }

    func testCoordinatesForPolygon() {
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)

        XCTAssertEqual(coordinates.count, polygon.coordinates.count)

        for (coordinate1, coordinate2) in zip(coordinates, polygon.coordinates) {
            XCTAssertEqual(coordinate1.latitude, coordinate2.latitude, accuracy: 0.000000001)
            XCTAssertEqual(coordinate1.longitude, coordinate2.longitude, accuracy: 0.000000001)
        }
    }
}

#endif
