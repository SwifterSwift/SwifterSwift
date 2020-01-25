//
//  CLVisitExtensionsTests.swift
//  SwifterSwift
//
//  Created by Trevor Phillips on 09/01/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreLocation) && (os(iOS) || targetEnvironment(macCatalyst))
import CoreLocation

final class CLVisitExtensionsTests: XCTestCase {

    func testLocation() {
        let visit = CLVisit()
        let location = visit.location

        XCTAssertEqual(visit.coordinate.latitude, location.coordinate.latitude)
        XCTAssertEqual(visit.coordinate.longitude, location.coordinate.longitude)
    }

}

#endif
