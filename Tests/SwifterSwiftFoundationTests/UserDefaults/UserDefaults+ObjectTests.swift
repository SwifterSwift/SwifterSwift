// UserDefaults+ObjectTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct UserDefaultsObjectTests {
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
    func decodesStoredJSONData() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(Data(#"{"name": "Zoë 👩🏽‍💻", "age": 30}"#.utf8), forKey: "profile")
        #expect(try defaults.object(Profile.self, forKey: "profile") == Profile(name: "Zoë 👩🏽‍💻", age: 30))
    }

    @Test
    func readsValuesEncodedByJSONEncoder() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let profile = Profile(name: "Taylor", age: 41)
        defaults.set(try JSONEncoder().encode(profile), forKey: "profile")
        #expect(try defaults.object(Profile.self, forKey: "profile") == profile)
        defaults.set(try JSONEncoder().encode([true, false]), forKey: "flags")
        #expect(try defaults.object([Bool].self, forKey: "flags") == [true, false])
    }

    @Test
    func returnsNilWhenNothingIsStored() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        #expect(try defaults.object(Profile.self, forKey: "profile") == nil)
    }

    @Test
    func returnsNilWhenTheStoredValueIsNotData() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set("not data", forKey: "profile")
        #expect(try defaults.object(Profile.self, forKey: "profile") == nil)
        defaults.set(42, forKey: "number")
        #expect(try defaults.object(Int.self, forKey: "number") == nil)
    }

    @Test
    func throwsWhenTheDataIsNotValidJSON() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(Data("not json".utf8), forKey: "profile")
        #expect(throws: DecodingError.self) { try defaults.object(Profile.self, forKey: "profile") }
        defaults.set(Data(), forKey: "empty")
        #expect(throws: DecodingError.self) { try defaults.object(Profile.self, forKey: "empty") }
    }

    @Test
    func throwsWhenTheDataHasTheWrongShape() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        defaults.set(Data(#"{"name": "Taylor"}"#.utf8), forKey: "profile")
        #expect(throws: DecodingError.self) { try defaults.object(Profile.self, forKey: "profile") }
    }

    @Test
    func usesTheGivenDecoder() throws {
        let (defaults, suiteName) = try makeTemporaryDefaults()
        defer { defaults.removePersistentDomain(forName: suiteName) }
        struct Account: Decodable, Equatable {
            var displayName: String
        }
        defaults.set(Data(#"{"display_name": "Taylor"}"#.utf8), forKey: "account")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        #expect(
            try defaults.object(Account.self, forKey: "account", decoder: decoder) == Account(displayName: "Taylor"))
        #expect(throws: DecodingError.self) { try defaults.object(Account.self, forKey: "account") }
    }
}
#endif
