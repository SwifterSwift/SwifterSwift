//
//  CLLocationArrayExtensionsTests.swift
//  SwifterSwift
//
//  Created by Trevor Phillips on 09/01/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreLocation)
import CoreLocation

final class CLLocationArrayExtensionsTests: XCTestCase {

    @available(tvOS 10.0, macOS 10.12, watchOS 3.0, *)
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
