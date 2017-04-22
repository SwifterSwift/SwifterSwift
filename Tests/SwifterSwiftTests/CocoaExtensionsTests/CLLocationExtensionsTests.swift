//
//  CLLocationExtensionsTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 21/04/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
import CoreLocation

class CLLocationExtensionsTests: XCTestCase {
    
    func testMidLocation() {
        let location = CLLocation(latitude: -15.822877, longitude: -47.941839)
        let other = CLLocation(latitude: -15.692030, longitude: -47.594397)
        
        let mid = CLLocation.midLocation(start: location, end: other)

        XCTAssertEqualWithAccuracy(mid.coordinate.latitude, -15.7575223324019, accuracy: 0.0000000000001)
        XCTAssertEqualWithAccuracy(mid.coordinate.longitude, -47.7680620274339, accuracy: 0.0000000000001)

    }
    
    func testBearing() {
        let location = CLLocation(latitude: 38.6318909290283, longitude: -90.2828979492187)
        let other = CLLocation(latitude: 38.5352759115441, longitude: -89.8448181152343)
        let bearing = location.bearing(to: other)
        
        XCTAssertEqualWithAccuracy(bearing, 105.619, accuracy: 0.001)
    }
}
