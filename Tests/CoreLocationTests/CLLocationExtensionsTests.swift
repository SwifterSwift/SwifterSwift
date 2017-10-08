//
//  CLLocationExtensionsTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 21/04/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
import CoreLocation

final class CLLocationExtensionsTests: XCTestCase {
	
	func testMidLocation() {
		let a = CLLocation(latitude: -15.822877, longitude: -47.941839)
		let b = CLLocation(latitude: -15.692030, longitude: -47.594397)
		let mid = CLLocation.midLocation(start: a, end: b)
		
		XCTAssertEqual(mid.coordinate.latitude, -15.7575223324019, accuracy: 0.0000000000001)
		XCTAssertEqual(mid.coordinate.longitude, -47.7680620274339, accuracy: 0.0000000000001)
		
		XCTAssertEqual(a.midLocation(to: b).coordinate.latitude, -15.7575223324019, accuracy: 0.0000000000001)
		XCTAssertEqual(a.midLocation(to: b).coordinate.longitude, -47.7680620274339, accuracy: 0.0000000000001)
		
	}
	
	func testBearing() {
		let a = CLLocation(latitude: 38.6318909290283, longitude: -90.2828979492187)
		let b = CLLocation(latitude: 38.5352759115441, longitude: -89.8448181152343)
		let bearing = a.bearing(to: b)
		
		XCTAssertEqual(bearing, 105.619, accuracy: 0.001)
	}
}
