//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## Foundation extensions

//: ### Date extensions

// Check if date is in today
Date().isInToday

// Add 1 month to current date
var date = Date()
date.add(.month, value: 1)

// Return date at the beginning of current day
Date().beginning(of: .day)

// Return date at the end of current month
Date().end(of: .month)

// Check if date is in current calendar unit
Date().isInCurrent(.month)

// Return iso8601 string for date
Date().iso8601String

// Create date from iso8601 string
let date1 = Date(iso8601String: "2016-08-23T21:26:15.287Z")

// Create date from DateComponents
let date2 = Date(year: 2016, month: 8, day: 15) // other components are set to current by default.
let date3 = Date(hour: 9, minute: 18, second: 1) // other components are set to current by default.

// Represent date as a string with ease
Date().dateString(ofStyle: .medium)
Date().timeString(ofStyle: .short)
Date().dateTimeString()

// Get day name or month name from a date
Date().dayName(ofStyle: .full)
Date().monthName(ofStyle: .threeLetters)

//: [Next](@next)
