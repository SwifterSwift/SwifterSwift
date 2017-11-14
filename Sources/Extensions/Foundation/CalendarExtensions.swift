//
//  CalendarExtensions.swift
//  SwifterSwift
//
//  Created by Chaithanya Prathyush on 09/11/17.
//  Copyright © 2017 SwifterSwift
//

import Foundation

// MARK: - Methods
public extension Calendar {
    /// SwifterSwift: Return the number of days in the month for a specified 'Date'.
    ///
    ///         let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///         Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    public func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// SwifterSwift: Return the number of days in the year for specified 'Date'.
    ///
    /// - Parameter date: the date from which the year is obtained
    /// - Returns: number of days in the year of 'date'
    public func numberOfDaysInYear(for date: Date) -> Int {
        return range(of: .day, in: .year, for: date)?.count ?? 0
    }
    
    /// SwifterSwift: Return the number of months in a year for specified 'date'
    ///
    ///         let calendar = Calendar(identifier: .gregorian)
    ///         calendar.numberOfMonthsInYear(for: Date()) -> 12
    ///
    /// - Parameter date: the date from which the year is obtained
    /// - Returns: number of days in the year of 'date'
    public func numberOfMonthsInYear(for date: Date) -> Int {
        return range(of: .month, in: .year, for: date)?.count ?? 0
    }
}
