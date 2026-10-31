// HKActivitySummary+IsStandGoalMet.swift - Copyright 2026 SwifterSwift

#if canImport(HealthKit) && !os(tvOS)
import HealthKit

public extension HKActivitySummary {
    /// SwifterSwift: Whether the user reached their stand goal for the day, closing the Stand ring.
    ///
    /// This compares `appleStandHours` with `standHoursGoal`, and reaching the goal exactly counts as meeting it.
    ///
    /// The result is `false` if the summary has no stand goal (`standHoursGoal` is `nil`), because there's no ring to
    /// close.
    ///
    /// ```swift
    /// let summary = HKActivitySummary()
    /// summary.standHoursGoal = HKQuantity(unit: .count(), doubleValue: 12)
    /// summary.appleStandHours = HKQuantity(unit: .count(), doubleValue: 12)
    /// summary.isStandGoalMet  // true
    ///
    /// summary.standHoursGoal = nil
    /// summary.isStandGoalMet  // false
    /// ```
    var isStandGoalMet: Bool {
        guard let goal = standHoursGoal else {
            return false
        }
        return appleStandHours.compare(goal) != .orderedAscending
    }
}
#endif
