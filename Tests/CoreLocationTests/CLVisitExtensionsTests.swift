// CLVisitExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

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
