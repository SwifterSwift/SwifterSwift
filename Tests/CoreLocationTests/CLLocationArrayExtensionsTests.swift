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

    func testDistance() {
        let locations = [
            CLLocation(latitude: 41.0, longitude: -111.0),
            CLLocation(latitude: 41.0, longitude: -112.0),
            CLLocation(latitude: 41.0, longitude: -113.0)
        ]

        XCTAssertEqual(locations.distance(unit: .kilometers).value, 168.27, accuracy: 0.01)
    }

}

#endif
