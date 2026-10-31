// HKActivitySummary+IsMoveGoalMetTests.swift - Copyright 2026 SwifterSwift

#if canImport(HealthKit) && !os(tvOS)
import HealthKit
import SwifterSwiftHealthKit
import Testing

struct HKActivitySummaryIsMoveGoalMetTests {
    func makeSummary(
        mode: HKActivityMoveMode,
        energy: Double = 0,
        energyGoal: Double = 0,
        moveMinutes: Double = 0,
        moveMinutesGoal: Double = 0
    ) -> HKActivitySummary {
        let summary = HKActivitySummary()
        summary.activityMoveMode = mode
        summary.activeEnergyBurned = HKQuantity(unit: .kilocalorie(), doubleValue: energy)
        summary.activeEnergyBurnedGoal = HKQuantity(unit: .kilocalorie(), doubleValue: energyGoal)
        summary.appleMoveTime = HKQuantity(unit: .minute(), doubleValue: moveMinutes)
        summary.appleMoveTimeGoal = HKQuantity(unit: .minute(), doubleValue: moveMinutesGoal)
        return summary
    }

    @Test(arguments: [(200.0, 400.0, false), (399.9, 400, false), (400, 400, true), (600, 400, true), (0, 0, true)])
    func comparesActiveEnergyInActiveEnergyMode(energy: Double, goal: Double, expected: Bool) {
        let summary = makeSummary(mode: .activeEnergy, energy: energy, energyGoal: goal)
        #expect(summary.isMoveGoalMet == expected)
    }

    @Test(arguments: [(10.0, 30.0, false), (29.9, 30, false), (30, 30, true), (45, 30, true), (0, 0, true)])
    func comparesMoveTimeInMoveTimeMode(minutes: Double, goal: Double, expected: Bool) {
        let summary = makeSummary(mode: .appleMoveTime, moveMinutes: minutes, moveMinutesGoal: goal)
        #expect(summary.isMoveGoalMet == expected)
    }

    @Test
    func ignoresActiveEnergyInMoveTimeMode() {
        let notMet = makeSummary(
            mode: .appleMoveTime,
            energy: 900,
            energyGoal: 400,
            moveMinutes: 10,
            moveMinutesGoal: 30
        )
        #expect(!notMet.isMoveGoalMet)

        let met = makeSummary(mode: .appleMoveTime, energy: 0, energyGoal: 400, moveMinutes: 30, moveMinutesGoal: 30)
        #expect(met.isMoveGoalMet)
    }

    @Test
    func ignoresMoveTimeInActiveEnergyMode() {
        let notMet = makeSummary(
            mode: .activeEnergy,
            energy: 100,
            energyGoal: 400,
            moveMinutes: 60,
            moveMinutesGoal: 30
        )
        #expect(!notMet.isMoveGoalMet)

        let met = makeSummary(mode: .activeEnergy, energy: 400, energyGoal: 400, moveMinutes: 0, moveMinutesGoal: 30)
        #expect(met.isMoveGoalMet)
    }

    @Test(arguments: [
        (HKUnit.jouleUnit(with: .kilo), 1_700.0, true),
        (.jouleUnit(with: .kilo), 1_600, false),
        (.largeCalorie(), 400, true),
        (.kilocalorie(), 399, false)
    ])
    func comparesAcrossEnergyUnits(unit: HKUnit, value: Double, expected: Bool) {
        let summary = makeSummary(mode: .activeEnergy, energyGoal: 400)
        summary.activeEnergyBurned = HKQuantity(unit: unit, doubleValue: value)
        #expect(summary.isMoveGoalMet == expected)
    }

    @Test
    func comparesAcrossTimeUnits() {
        let summary = makeSummary(mode: .appleMoveTime, moveMinutesGoal: 30)
        summary.appleMoveTime = HKQuantity(unit: .second(), doubleValue: 1_800)
        #expect(summary.isMoveGoalMet)
        summary.appleMoveTime = HKQuantity(unit: .hour(), doubleValue: 0.25)
        #expect(!summary.isMoveGoalMet)
    }

    @Test
    func usesActiveEnergyForANewSummary() {
        let summary = HKActivitySummary()
        #expect(summary.activityMoveMode == .activeEnergy)
        summary.activeEnergyBurnedGoal = HKQuantity(unit: .kilocalorie(), doubleValue: 400)
        #expect(!summary.isMoveGoalMet)
        summary.activeEnergyBurned = HKQuantity(unit: .kilocalorie(), doubleValue: 400)
        #expect(summary.isMoveGoalMet)
    }
}
#endif
