// UserDefaults+SetObjectTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct UserDefaultsSetObjectTests {
    struct Profile: Codable, Equatable {
        var name: String
        var age: Int
    }

    /// Returns an empty, uniquely named defaults suite. Delete it with `removePersistentDomain(forName:)`.
    func makeTemporaryDefaults() throws -> (defaults: UserDefaults, suiteName: String) {
        let suiteName = "SwifterSwiftTests.\(UUID().uuidString)"
        return (try #require(UserDefaults(suiteName: suiteName)), suiteName)
    }

    @Test
    func storesTheValueAsJSONData() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        try defaults.set(object: Profile(name: "Zoë 👩🏽‍💻", age: 30), forKey: "profile")
        let data = try #require(defaults.data(forKey: "profile"))
        #expect(try JSONDecoder().decode(Profile.self, from: data) == Profile(name: "Zoë 👩🏽‍💻", age: 30))
    }

    @Test
    func replacesTheStoredValue() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        try defaults.set(object: [1, 2, 3], forKey: "numbers")
        try defaults.set(object: [4], forKey: "numbers")
        let data = try #require(defaults.data(forKey: "numbers"))
        #expect(try JSONDecoder().decode([Int].self, from: data) == [4])
    }

    @Test
    func throwsAndKeepsTheStoredValueWhenEncodingFails() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        try defaults.set(object: [1.5], forKey: "values")
        let stored = defaults.data(forKey: "values")

        // The default JSONEncoder can't encode NaN.
        #expect(throws: EncodingError.self) { try defaults.set(object: [Double.nan], forKey: "values") }
        #expect(defaults.data(forKey: "values") == stored)
        #expect(stored != nil)
    }

    @Test
    func usesTheGivenEncoder() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        struct Account: Encodable {
            var displayName: String
        }
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        try defaults.set(object: Account(displayName: "Taylor"), forKey: "account", encoder: encoder)
        let data = try #require(defaults.data(forKey: "account"))
        #expect(String(decoding: data, as: UTF8.self) == #"{"display_name":"Taylor"}"#)
    }

    @Test
    func leavesPlainSetCallsToTheSDK() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        // Without the `object:` label, `set(_:forKey:)` still stores a plain property list value.
        defaults.set(5, forKey: "count")
        #expect(defaults.integer(forKey: "count") == 5)
        #expect(defaults.data(forKey: "count") == nil)
    }
}
#endif
