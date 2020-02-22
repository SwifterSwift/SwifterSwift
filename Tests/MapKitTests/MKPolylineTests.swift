//
//  MKPolylineTests.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 3/8/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(MapKit)
import MapKit

import struct CoreLocation.CLLocationCoordinate2D

final class MKPolylineTests: XCTestCase {

    let coordinates = [
        (37.330514, -121.888863),
        (37.330832, -121.888337),
        (37.329599, -121.886859),
        (37.330019, -121.885993),
        (37.329767, -121.885813)
        ].map(CLLocationCoordinate2D.init)

    let locations = [
        (37.330514, -121.888863),
        (37.330832, -121.888337),
        (37.329599, -121.886859),
        (37.330019, -121.885993),
        (37.329767, -121.885813)
        ].map(CLLocation.init)

    func testInitWithCoordinates() {
        let polyline = MKPolyline(coordinates: coordinates)
        for (coordinate1, coordinate2) in zip(polyline.coordinates, coordinates) {
            XCTAssertEqual(coordinate1.latitude, coordinate2.latitude, accuracy: 0.000000001)
            XCTAssertEqual(coordinate1.longitude, coordinate2.longitude, accuracy: 0.000000001)
        }
    }

    func testInitWithLocations() {
        let newCoordinates = locations.map { $0.coordinate }

        let polyline = MKPolyline(locations: locations)
        for (coordinate1, coordinate2) in zip(polyline.coordinates, newCoordinates) {
            XCTAssertEqual(coordinate1.latitude, coordinate2.latitude, accuracy: 0.000000001)
            XCTAssertEqual(coordinate1.longitude, coordinate2.longitude, accuracy: 0.000000001)
        }
    }

    func testCoordinates() {
        let polyline = MKPolyline(coordinates: coordinates)

        XCTAssertEqual(coordinates.count, polyline.coordinates.count)

        for (coordinate1, coordinate2) in zip(coordinates, polyline.coordinates) {
            XCTAssertEqual(coordinate1.latitude, coordinate2.latitude, accuracy: 0.000000001)
            XCTAssertEqual(coordinate1.longitude, coordinate2.longitude, accuracy: 0.000000001)
        }
    }

}

#endif
