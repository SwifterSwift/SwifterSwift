//
//  HKActivitySummaryExtensions.swift
//  SwifterSwift
//
//  Created by Gilbert Lo on 7/3/20.
//  Copyright © 2020 SwifterSwift
//

#if canImport(HealthKit)
import HealthKit

// MARK: - Properties
@available(watchOS 2.2, *)
public extension HKActivitySummary {

    /// SwifterSwift: Check if stand goal is met
    var isStandGoalMet: Bool {
        let unit = HKUnit.count()
        let standHours = appleStandHours.doubleValue(for: unit)
        let goal = appleStandHoursGoal.doubleValue(for: unit)
        return standHours >= goal
    }

    /// SwifterSwift: Check if exercise time goal is met
    var isExerciseGoalMet: Bool {
        let unit = HKUnit.minute()
        let exerciseTime = appleExerciseTime.doubleValue(for: unit)
        let goal = appleExerciseTimeGoal.doubleValue(for: unit)
        return exerciseTime >= goal
    }

    /// SwifterSwift: Check if active energy goal is met
    var isEnergyGoalMet: Bool {
        let unit = HKUnit.jouleUnit(with: .kilo)
        let energyBurned = activeEnergyBurned.doubleValue(for: unit)
        let goal = activeEnergyBurnedGoal.doubleValue(for: unit)
        return energyBurned >= goal
    }

}

#endif
