// MeasurementExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

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

    func testPlusEquals() {
        var minutes = Measurement(value: 100, unit: UnitDuration.minutes)
        minutes += Measurement(value: 200, unit: UnitDuration.minutes)

        XCTAssertEqual(minutes.value, 300)
    }

    func testMinusEquals() {
        var minutes = Measurement(value: 250, unit: UnitDuration.minutes)
        minutes -= Measurement(value: 100, unit: UnitDuration.minutes)

        XCTAssertEqual(minutes.value, 150)
    }

    func testMultiplyEquals() {
        var minutes = Measurement(value: 250, unit: UnitDuration.minutes)
        minutes *= 3

        XCTAssertEqual(minutes.value, 750)
    }

    func testDivideEquals() {
        var minutes = Measurement(value: 250, unit: UnitDuration.minutes)
        minutes /= 5

        XCTAssertEqual(minutes.value, 50)
    }
}

#endif
