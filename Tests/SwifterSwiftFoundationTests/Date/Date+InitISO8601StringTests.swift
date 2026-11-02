// Date+InitISO8601StringTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateInitISO8601StringTests {
    // 2017-01-12T16:48:00Z
    private static let reference = 1_484_239_680.0

    @Test(arguments: [
        ("2017-01-12T16:48:00Z", reference),
        ("2017-01-12T16:48:00.959Z", reference + 0.959),
        ("2017-01-12T16:48:00.5Z", reference + 0.5),
        ("2017-01-12T16:48:00.123456Z", reference + 0.123456),
        ("2017-01-12T19:48:00+03:00", reference),
        ("2017-01-12T19:48:00.959+03:00", reference + 0.959),
        ("2017-01-12T11:48:00-0500", reference),
        ("2017-01-12T16:48:00+00:00", reference),
        ("2017-01-13T06:48:00+14:00", reference)
    ])
    func parsesStringsWithAndWithoutFractionalSeconds(_ string: String, _ expected: Double) throws {
        let date = try #require(Date(iso8601String: string))
        #expect(abs(date.timeIntervalSince1970 - expected) < 0.000_001)
    }

    @Test
    func parsesDatesBeforeTheReferenceDateAndInLeapYears() throws {
        let landing = try #require(Date(iso8601String: "1969-07-20T20:17:40Z"))
        #expect(landing.timeIntervalSince1970 == -14_182_940)
        let leapDay = try #require(Date(iso8601String: "2024-02-29T23:59:59.999Z"))
        #expect(abs(leapDay.timeIntervalSince1970 - 1_709_251_199.999) < 0.000_001)
    }

    @Test(arguments: [
        "", "not a date", "2017-01-12", "2017-01-12T16:48:00", "2017-01-12T16:48:00.959", "2017-01-12 16:48:00Z",
        "20170112T164800Z", "16:48:00Z", "2017-01-12T16:48Z", "2017-13-45T16:48:00Z", "2017-01-12T16:48:00,959Z",
        " 2017-01-12T16:48:00Z", "２０１７-01-12T16:48:00Z", "2017-01-12T16:48:00.Z"
    ])
    func returnsNilForStringsThatArentFullDateTimes(_ string: String) {
        #expect(Date(iso8601String: string) == nil)
    }
}
#endif
