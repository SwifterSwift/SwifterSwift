// HKActivitySummary+IsExerciseTimeGoalMet.swift - Copyright 2026 SwifterSwift

#if canImport(HealthKit) && !os(tvOS)
import HealthKit

public extension HKActivitySummary {
    /// SwifterSwift: Whether the user reached their exercise goal for the day, closing the Exercise ring.
    ///
    /// This compares `appleExerciseTime` with `exerciseTimeGoal`, and reaching the goal exactly counts as meeting it.
    /// The quantities can use different time units, such as minutes and seconds.
    ///
    /// The result is `false` if the summary has no exercise goal (`exerciseTimeGoal` is `nil`), because there's no
    /// ring to close.
    ///
    /// ```swift
    /// let summary = HKActivitySummary()
    /// summary.exerciseTimeGoal = HKQuantity(unit: .minute(), doubleValue: 30)
    /// summary.appleExerciseTime = HKQuantity(unit: .minute(), doubleValue: 25)
    /// summary.isExerciseTimeGoalMet  // false
    ///
    /// summary.appleExerciseTime = HKQuantity(unit: .second(), doubleValue: 1_800)
    /// summary.isExerciseTimeGoalMet  // true
    /// ```
    var isExerciseTimeGoalMet: Bool {
        guard let goal = exerciseTimeGoal else {
            return false
        }
        return appleExerciseTime.compare(goal) != .orderedAscending
    }
}
#endif
