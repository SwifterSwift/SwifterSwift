// MeasurementExtensionsTests.swift - Copyright 2021 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

@available(OSX 10.12, tvOS 10.0, watchOS 3.0, *)
class MeasurementExtensionsTests: XCTestCase {
    func testDegree() {
        let angle = Measurement.degree(2.28)
        XCTAssertEqual(angle.unit, UnitAngle.degrees)
        XCTAssertEqual(angle.value, 2.28)
    }

    func testArcMinutes() {
        let angle = Measurement.arcMinutes(2.28)
        XCTAssertEqual(angle.unit, UnitAngle.arcMinutes)
        XCTAssertEqual(angle.value, 2.28)
    }

    func testArcSeconds() {
        let angle = Measurement.arcSeconds(2.28)
        XCTAssertEqual(angle.unit, UnitAngle.arcSeconds)
        XCTAssertEqual(angle.value, 2.28)
    }

    func testRadians() {
        let angle = Measurement.radians(2.28)
        XCTAssertEqual(angle.unit, UnitAngle.radians)
        XCTAssertEqual(angle.value, 2.28)
    }

    func testGradians() {
        let angle = Measurement.gradians(2.28)
        XCTAssertEqual(angle.unit, UnitAngle.gradians)
        XCTAssertEqual(angle.value, 2.28)
    }

    func testRevolutions() {
        let angle = Measurement.revolutions(2.28)
        XCTAssertEqual(angle.unit, UnitAngle.revolutions)
        XCTAssertEqual(angle.value, 2.28)
    }
}

#endif
