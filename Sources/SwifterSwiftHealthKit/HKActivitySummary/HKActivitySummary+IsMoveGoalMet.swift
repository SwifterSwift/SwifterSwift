// HKActivitySummary+IsMoveGoalMet.swift - Copyright 2026 SwifterSwift

#if canImport(HealthKit) && !os(tvOS)
import HealthKit

public extension HKActivitySummary {
    /// SwifterSwift: Whether the user reached their move goal for the day, closing the Move ring.
    ///
    /// The Move ring tracks either active energy or move time, depending on `activityMoveMode`:
    ///
    /// - For `.activeEnergy`, this compares `activeEnergyBurned` with `activeEnergyBurnedGoal`.
    /// - For `.appleMoveTime`, used by people who track move minutes instead of calories, this compares
    ///   `appleMoveTime` with `appleMoveTimeGoal`.
    ///
    /// Reaching the goal exactly counts as meeting it, and the quantities can use different units of the same kind,
    /// such as kilocalories and kilojoules. The result is `false` for a move mode this extension doesn't know about.
    ///
    /// ```swift
    /// let summary = HKActivitySummary()
    /// summary.activityMoveMode = .activeEnergy
    /// summary.activeEnergyBurnedGoal = HKQuantity(unit: .kilocalorie(), doubleValue: 400)
    /// summary.activeEnergyBurned = HKQuantity(unit: .kilocalorie(), doubleValue: 450)
    /// summary.isMoveGoalMet  // true
    ///
    /// summary.activityMoveMode = .appleMoveTime
    /// summary.appleMoveTimeGoal = HKQuantity(unit: .minute(), doubleValue: 30)
    /// summary.appleMoveTime = HKQuantity(unit: .minute(), doubleValue: 10)
    /// summary.isMoveGoalMet  // false
    /// ```
    var isMoveGoalMet: Bool {
        switch activityMoveMode {
        case .activeEnergy:
            activeEnergyBurned.compare(activeEnergyBurnedGoal) != .orderedAscending
        case .appleMoveTime:
            appleMoveTime.compare(appleMoveTimeGoal) != .orderedAscending
        @unknown default:
            false
        }
    }
}
#endif
