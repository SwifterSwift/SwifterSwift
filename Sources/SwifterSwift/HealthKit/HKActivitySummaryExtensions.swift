// HKActivitySummaryExtensions.swift - Copyright 2020 SwifterSwift
// HeathKit is not available for tvOS, available only on iOS 8.0+ Mac Catalyst 13.0+ watchOS 2.0+
// See: https://developer.apple.com/documentation/healthkit
#if !os(tvOS)
#if canImport(HealthKit)
import HealthKit

// MARK: - Properties

@available(watchOS 2.2, *)
public extension HKActivitySummary {
    /// SwifterSwift: Check if stand goal is met.
    var isStandGoalMet: Bool { appleStandHoursGoal.compare(appleStandHours) != .orderedDescending }

    /// SwifterSwift: Check if exercise time goal is met.
    var isExerciseTimeGoalMet: Bool { appleExerciseTimeGoal.compare(appleExerciseTime) != .orderedDescending }

    /// SwifterSwift: Check if active energy goal is met.
    var isEnergyBurnedGoalMet: Bool { activeEnergyBurnedGoal.compare(activeEnergyBurned) != .orderedDescending }
}
#endif
#endif
