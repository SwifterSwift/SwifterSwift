// CLLocationArrayExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CoreLocation)
import CoreLocation

final class CLLocationArrayExtensionsTests: XCTestCase {
    func testDistance() {
        let locations1 = [CLLocation]()
        let locations2 = [
            CLLocation(latitude: 41.0, longitude: -111.0)
        ]
        let locations3 = [
            CLLocation(latitude: 41.0, longitude: -111.0),
            CLLocation(latitude: 41.0, longitude: -112.0),
            CLLocation(latitude: 41.0, longitude: -113.0)
        ]

        XCTAssertEqual(locations1.distance(unitLength: .kilometers).value, 0.0, accuracy: 0.01)
        XCTAssertEqual(locations2.distance(unitLength: .kilometers).value, 0.0, accuracy: 0.01)
        XCTAssertEqual(locations3.distance(unitLength: .kilometers).value, 168.27, accuracy: 0.01)
    }
}

#endif
