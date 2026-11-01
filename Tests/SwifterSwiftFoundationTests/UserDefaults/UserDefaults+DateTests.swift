// UserDefaults+DateTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct UserDefaultsDateTests {
    /// Returns an empty, uniquely named defaults suite. Delete it with `removePersistentDomain(forName:)`.
    func makeTemporaryDefaults() throws -> (defaults: UserDefaults, suiteName: String) {
        let suiteName = "SwifterSwiftTests.\(UUID().uuidString)"
        return (try #require(UserDefaults(suiteName: suiteName)), suiteName)
    }

    @Test(arguments: [
        Date(timeIntervalSince1970: 1_793_370_309.123),
        Date(timeIntervalSince1970: 0),
        Date(timeIntervalSince1970: -1_000_000_000.5),
        .distantPast,
        .distantFuture
    ])
    func readsAStoredDate(_ date: Date) throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(date, forKey: "date")
        // Compares the seconds rather than the dates, so a failure shows the values even where a date can't be
        // printed, as on Windows for dates before 1970.
        #expect(defaults.date(forKey: "date")?.timeIntervalSinceReferenceDate == date.timeIntervalSinceReferenceDate)
    }

    @Test
    func returnsNilWhenNothingIsStored() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        #expect(defaults.date(forKey: "date") == nil)
        #expect(defaults.date(forKey: "") == nil)
    }

    @Test
    func returnsNilAfterTheValueIsRemoved() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(Date(timeIntervalSince1970: 0), forKey: "date")
        defaults.removeObject(forKey: "date")
        #expect(defaults.date(forKey: "date") == nil)
    }

    @Test
    func doesNotConvertOtherValues() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set("2026-10-30T14:25:09Z", forKey: "string")
        defaults.set(1_793_370_309.0, forKey: "seconds")
        defaults.set(Data([1, 2, 3]), forKey: "data")
        defaults.set([Date(timeIntervalSince1970: 0)], forKey: "array")
        defaults.set(["date": Date(timeIntervalSince1970: 0)], forKey: "dictionary")
        for key in ["string", "seconds", "data", "array", "dictionary"] {
            #expect(defaults.date(forKey: key) == nil, "\(key)")
        }
    }

    @Test
    func readsTheLatestValue() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(Date(timeIntervalSince1970: 0), forKey: "date")
        defaults.set(Date(timeIntervalSince1970: 60), forKey: "date")
        #expect(defaults.date(forKey: "date") == Date(timeIntervalSince1970: 60))
        defaults.set("not a date", forKey: "date")
        #expect(defaults.date(forKey: "date") == nil)
    }

    @Test
    func readsUnicodeKeys() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(Date(timeIntervalSince1970: 0), forKey: "تاريخ 🧑‍💻")
        #expect(defaults.date(forKey: "تاريخ 🧑‍💻") == Date(timeIntervalSince1970: 0))
    }
}
#endif
