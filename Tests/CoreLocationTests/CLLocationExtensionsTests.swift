//
//  CLLocationExtensionsTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 21/04/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreLocation)
import CoreLocation

final class CLLocationExtensionsTests: XCTestCase {

    func testMidLocation() {
        let aLoc = CLLocation(latitude: -15.822877, longitude: -47.941839)
        let bLoc = CLLocation(latitude: -15.692030, longitude: -47.594397)
        let mid = CLLocation.midLocation(start: aLoc, end: bLoc)

        XCTAssertEqual(mid.coordinate.latitude, -15.7575223324019, accuracy: 0.0000000000001)
        XCTAssertEqual(mid.coordinate.longitude, -47.7680620274339, accuracy: 0.0000000000001)

        XCTAssertEqual(aLoc.midLocation(to: bLoc).coordinate.latitude, -15.7575223324019, accuracy: 0.0000000000001)
        XCTAssertEqual(aLoc.midLocation(to: bLoc).coordinate.longitude, -47.7680620274339, accuracy: 0.0000000000001)
    }

    func testBearing() {
        let aLoc = CLLocation(latitude: 38.6318909290283, longitude: -90.2828979492187)
        let bLoc = CLLocation(latitude: 38.5352759115441, longitude: -89.8448181152343)
        let bearing = aLoc.bearing(to: bLoc)

        XCTAssertEqual(bearing, 105.619, accuracy: 0.001)
    }

    func testPlacemark() {
        let validExpectation = XCTestExpectation(description: "Retrieve placemarks from a valid location")
        let invalidExpectation = XCTestExpectation(description: "Retrieve placemarks from a invalid location")

        let validLoc = CLLocation(latitude: 36.099190, longitude: -115.175217)
        let invalidLoc = CLLocation(latitude: 469.696969, longitude: 469.696969)

        validLoc.placemarks { (placemarks) in
            XCTAssertNotNil(placemarks)
            validExpectation.fulfill()
        }

        invalidLoc.placemarks { (placemarks) in
            XCTAssertNil(placemarks)
            invalidExpectation.fulfill()
        }

        wait(for: [validExpectation, invalidExpectation], timeout: 10.0)
    }

}

#endif
