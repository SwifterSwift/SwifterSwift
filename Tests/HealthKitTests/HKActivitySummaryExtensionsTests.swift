// HKActivitySummaryExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if !os(tvOS)
#if canImport(HealthKit)
import HealthKit

@available(macOS 13.0, *)
class HKActivitySummaryExtensionsTests: XCTestCase {
    func testIsStandGoalMet() {
        let unit = HKUnit.count()
        let summary = HKActivitySummary()
        if #available(iOS 16.0, watchOS 9.0, *) {
            summary.standHoursGoal = HKQuantity(unit: unit, doubleValue: 12)
        } else {
            summary.appleStandHoursGoal = HKQuantity(unit: unit, doubleValue: 12)
        }

        summary.appleStandHours = HKQuantity(unit: unit, doubleValue: 6)
        XCTAssertFalse(summary.isStandGoalMet)

        summary.appleStandHours = HKQuantity(unit: unit, doubleValue: 12)
        XCTAssert(summary.isStandGoalMet)

        summary.appleStandHours = HKQuantity(unit: unit, doubleValue: 14)
        XCTAssert(summary.isStandGoalMet)
    }

    func testIsExerciseTimeGoalMet() {
        let unit = HKUnit.minute()
        let summary = HKActivitySummary()
        if #available(iOS 16.0, watchOS 9.0, *) {
            summary.exerciseTimeGoal = HKQuantity(unit: unit, doubleValue: 30)
        } else {
            summary.appleExerciseTimeGoal = HKQuantity(unit: unit, doubleValue: 30)
        }

        summary.appleExerciseTime = HKQuantity(unit: unit, doubleValue: 6)
        XCTAssertFalse(summary.isExerciseTimeGoalMet)

        summary.appleExerciseTime = HKQuantity(unit: unit, doubleValue: 30)
        XCTAssert(summary.isExerciseTimeGoalMet)

        summary.appleExerciseTime = HKQuantity(unit: unit, doubleValue: 40)
        XCTAssert(summary.isExerciseTimeGoalMet)
    }

    func testIsEnergyBurnedGoalMet() {
        let unit = HKUnit.jouleUnit(with: .kilo)
        let summary = HKActivitySummary()
        summary.activeEnergyBurnedGoal = HKQuantity(unit: unit, doubleValue: 400)

        summary.activeEnergyBurned = HKQuantity(unit: unit, doubleValue: 200)
        XCTAssertFalse(summary.isEnergyBurnedGoalMet)

        summary.activeEnergyBurned = HKQuantity(unit: unit, doubleValue: 400)
        XCTAssert(summary.isEnergyBurnedGoalMet)

        summary.activeEnergyBurned = HKQuantity(unit: unit, doubleValue: 600)
        XCTAssert(summary.isEnergyBurnedGoalMet)
    }
}

#endif
#endif
