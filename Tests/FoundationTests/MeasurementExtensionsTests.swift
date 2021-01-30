// MeasurementExtensionsTests.swift - Copyright 2021 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

@available(OSX 10.12, tvOS 10.0, watchOS 3.0, *)
class MeasurementExtensionsTests: XCTestCase {
    private let angleValue = 2.28

    func testDegrees() {
        let angle = Measurement.degrees(angleValue)
        XCTAssertEqual(angle.unit, UnitAngle.degrees)
        XCTAssertEqual(angle.value, angleValue)
    }

    func testArcMinutes() {
        let angle = Measurement.arcMinutes(angleValue)
        XCTAssertEqual(angle.unit, UnitAngle.arcMinutes)
        XCTAssertEqual(angle.value, angleValue)
    }

    func testArcSeconds() {
        let angle = Measurement.arcSeconds(angleValue)
        XCTAssertEqual(angle.unit, UnitAngle.arcSeconds)
        XCTAssertEqual(angle.value, angleValue)
    }

    func testRadians() {
        let angle = Measurement.radians(angleValue)
        XCTAssertEqual(angle.unit, UnitAngle.radians)
        XCTAssertEqual(angle.value, angleValue)
    }

    func testGradians() {
        let angle = Measurement.gradians(angleValue)
        XCTAssertEqual(angle.unit, UnitAngle.gradians)
        XCTAssertEqual(angle.value, angleValue)
    }

    func testRevolutions() {
        let angle = Measurement.revolutions(angleValue)
        XCTAssertEqual(angle.unit, UnitAngle.revolutions)
        XCTAssertEqual(angle.value, angleValue)
    }
}

#endif
