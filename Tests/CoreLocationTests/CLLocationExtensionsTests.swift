// CLLocationExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

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

    func testInRange() {
        let aLoc = CLLocation(latitude: 37.575803, longitude: 126.976807)
        let bLoc = CLLocation(latitude: 37.572931, longitude: 126.976834)

        XCTAssert(aLoc.isInRange(of: bLoc, radius: 320))
        XCTAssert(aLoc.isInRange(of: bLoc, radius: 1050, unitLength: .feet))

        XCTAssertFalse(aLoc.isInRange(of: bLoc, radius: 300))
        XCTAssertFalse(aLoc.isInRange(of: bLoc, radius: 1000, unitLength: .feet))
    }
}

#endif
