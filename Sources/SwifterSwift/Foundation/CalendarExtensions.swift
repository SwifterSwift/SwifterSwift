// CalendarExtensions.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

// MARK: - Methods

public extension Calendar {
    /// SwifterSwift: Return the number of days in the month for a specified 'Date'.
    ///
    ///		let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///		Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }

    /// SwifterSwift: Return the number of days in the year for a specified 'Date'.
    ///
    ///     Calendar.current.numberOfDaysInYear(for: Date(year: 2020)) -> 366
    ///     Calendar.current.numberOfDaysInYear(for: Date(year: 2021)) -> 365
    ///
    /// - Parameter date: the date from which the number of days in year is calculated.
    /// - Returns: The number of days in the year of 'Date'.
    func numberOfDaysInYear(for date: Date) -> Int {
        guard let range = range(of: .day, in: .year, for: date) else { return 365 }
        return range.count
    }
}

#endif
