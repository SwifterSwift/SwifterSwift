// HKActivitySummary+IsExerciseTimeGoalMetTests.swift - Copyright 2026 SwifterSwift

#if canImport(HealthKit) && !os(tvOS)
import HealthKit
import SwifterSwiftHealthKit
import Testing

struct HKActivitySummaryIsExerciseTimeGoalMetTests {
    func makeSummary(minutes: Double, goal: Double?) -> HKActivitySummary {
        let summary = HKActivitySummary()
        summary.appleExerciseTime = HKQuantity(unit: .minute(), doubleValue: minutes)
        summary.exerciseTimeGoal = goal.map { HKQuantity(unit: .minute(), doubleValue: $0) }
        return summary
    }

    @Test(arguments: [
        (6.0, 30.0, false),
        (29.99, 30, false),
        (30, 30, true),
        (40, 30, true),
        (0, 30, false),
        (0, 0, true),
        (1_440, 1_440, true)
    ])
    func comparesExerciseTimeWithTheGoal(minutes: Double, goal: Double, expected: Bool) {
        #expect(makeSummary(minutes: minutes, goal: goal).isExerciseTimeGoalMet == expected)
    }

    @Test(arguments: [
        (HKUnit.second(), 1_800.0, true),
        (.second(), 1_799, false),
        (.hour(), 0.5, true),
        (.hour(), 0.49, false),
        (.minute(), 30, true)
    ])
    func comparesAcrossTimeUnits(unit: HKUnit, value: Double, expected: Bool) {
        let summary = makeSummary(minutes: 0, goal: 30)
        summary.appleExerciseTime = HKQuantity(unit: unit, doubleValue: value)
        #expect(summary.isExerciseTimeGoalMet == expected)
    }

    @Test(arguments: [0.0, 30, 600])
    func isNotMetWithoutAGoal(_ minutes: Double) {
        #expect(!makeSummary(minutes: minutes, goal: nil).isExerciseTimeGoalMet)
    }

    @Test
    func isNotMetForANewSummary() {
        #expect(!HKActivitySummary().isExerciseTimeGoalMet)
    }
}
#endif
