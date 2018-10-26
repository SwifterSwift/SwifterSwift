//
//  FoundationDeprecated.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 04/10/2018.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Foundation)
import Foundation

extension Date {

    /// SwifterSwift: Random date between two dates.
    ///
    ///     Date.random()
    ///     Date.random(from: Date())
    ///     Date.random(upTo: Date())
    ///     Date.random(from: Date(), upTo: Date())
    ///
    /// - Parameters:
    ///   - fromDate: minimum date (default is Date.distantPast)
    ///   - toDate: maximum date (default is Date.distantFuture)
    /// - Returns: random date between two dates.
    @available(*, deprecated: 4.7.0, message: "Use random(in:) or random(in:using:) instead")
    public static func random(from fromDate: Date = Date.distantPast, upTo toDate: Date = Date.distantFuture) -> Date {
        guard fromDate != toDate else {
            return fromDate
        }

        let diff = llabs(Int64(toDate.timeIntervalSinceReferenceDate - fromDate.timeIntervalSinceReferenceDate))
        var randomValue: Int64 = Int64.random(in: Int64.min...Int64.max)
        randomValue = llabs(randomValue%diff)

        let startReferenceDate = toDate > fromDate ? fromDate : toDate
        return startReferenceDate.addingTimeInterval(TimeInterval(randomValue))
    }

    /// SwifterSwift: Time zone used currently by system.
    ///
    ///        Date().timeZone -> Europe/Istanbul (current)
    ///
    @available(*, deprecated: 4.7.0, message: "`Date` objects are timezone-agnostic. Please use Calendar.current.timeZone instead.")
    public var timeZone: TimeZone {
        return Calendar.current.timeZone
    }

}
#endif
