// HKActivitySummary+IsStandGoalMetTests.swift - Copyright 2026 SwifterSwift

#if canImport(HealthKit) && !os(tvOS)
import HealthKit
import SwifterSwiftHealthKit
import Testing

struct HKActivitySummaryIsStandGoalMetTests {
    func makeSummary(hours: Double, goal: Double?) -> HKActivitySummary {
        let summary = HKActivitySummary()
        summary.appleStandHours = HKQuantity(unit: .count(), doubleValue: hours)
        summary.standHoursGoal = goal.map { HKQuantity(unit: .count(), doubleValue: $0) }
        return summary
    }

    @Test(arguments: [
        (6.0, 12.0, false),
        (11, 12, false),
        (12, 12, true),
        (14, 12, true),
        (24, 12, true),
        (0, 12, false),
        (0, 0, true),
        (1, 0, true)
    ])
    func comparesStandHoursWithTheGoal(hours: Double, goal: Double, expected: Bool) {
        #expect(makeSummary(hours: hours, goal: goal).isStandGoalMet == expected)
    }

    @Test(arguments: [0.0, 12, 24])
    func isNotMetWithoutAGoal(_ hours: Double) {
        #expect(!makeSummary(hours: hours, goal: nil).isStandGoalMet)
    }

    @Test
    func isNotMetForANewSummary() {
        #expect(!HKActivitySummary().isStandGoalMet)
    }

    @Test
    func isNotMetForAHugeGoal() {
        #expect(!makeSummary(hours: 24, goal: .greatestFiniteMagnitude).isStandGoalMet)
    }
}
#endif
