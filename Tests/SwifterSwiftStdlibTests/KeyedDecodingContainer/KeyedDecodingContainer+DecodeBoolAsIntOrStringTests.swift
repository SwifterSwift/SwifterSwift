// KeyedDecodingContainer+DecodeBoolAsIntOrStringTests.swift - Copyright 2026 SwifterSwift

// The extension itself needs only the standard library; the tests use Foundation's `JSONDecoder` to drive it.
#if canImport(Foundation)
import Foundation
import SwifterSwiftStdlib
import Testing

struct KeyedDecodingContainerDecodeBoolAsIntOrStringTests {
    struct Flag: Decodable {
        let value: Bool

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            value = try container.decodeBoolAsIntOrString(forKey: .value)
        }

        enum CodingKeys: CodingKey {
            case value
        }
    }

    func decode(_ json: String) throws -> Bool {
        try JSONDecoder().decode(Flag.self, from: Data(json.utf8)).value
    }

    @Test(arguments: [
        (#"{"value": true}"#, true),
        (#"{"value": false}"#, false),
        (#"{"value": 1}"#, true),
        (#"{"value": 0}"#, false),
        (#"{"value": "true"}"#, true),
        (#"{"value": "false"}"#, false),
        (#"{"value": "yes"}"#, true),
        (#"{"value": "no"}"#, false),
        (#"{"value": "1"}"#, true),
        (#"{"value": "0"}"#, false)
    ])
    func decodesUnambiguousValues(json: String, expected: Bool) throws {
        #expect(try decode(json) == expected)
    }

    @Test(arguments: ["TRUE", "True", "YES", "Yes", "FALSE", "No"])
    func ignoresTheCaseOfStrings(text: String) throws {
        #expect(try decode(#"{"value": "\#(text)"}"#) == ["true", "yes"].contains(text.lowercased()))
    }

    @Test(arguments: ["2", "-1", "10", "9223372036854775807"])
    func throwsDataCorruptedForOtherIntegers(number: String) {
        let error = #expect(throws: DecodingError.self) { try decode(#"{"value": \#(number)}"#) }
        guard case .dataCorrupted(let context) = error else {
            Issue.record("Expected dataCorrupted, got \(String(describing: error))")
            return
        }
        #expect(context.codingPath.map(\.stringValue) == ["value"])
    }

    @Test(arguments: ["Yolo", "abc", "", " true", "true ", "tru", "y", "on", "2", "１", "ｔｒｕｅ", "✅"])
    func throwsDataCorruptedForOtherStrings(text: String) {
        let error = #expect(throws: DecodingError.self) { try decode(#"{"value": "\#(text)"}"#) }
        guard case .dataCorrupted = error else {
            Issue.record("Expected dataCorrupted, got \(String(describing: error))")
            return
        }
    }

    @Test
    func throwsKeyNotFoundForAMissingKey() {
        let error = #expect(throws: DecodingError.self) { try decode("{}") }
        guard case .keyNotFound = error else {
            Issue.record("Expected keyNotFound, got \(String(describing: error))")
            return
        }
    }

    @Test
    func throwsTheDecodersErrorForNull() {
        // JSONDecoder reports null as a type mismatch; other decoders may throw valueNotFound.
        let error = #expect(throws: DecodingError.self) { try decode(#"{"value": null}"#) }
        if case .dataCorrupted = error {
            Issue.record("Expected the decoder's own error, got \(String(describing: error))")
        }
    }

    @Test(arguments: [#"{"value": [1]}"#, #"{"value": {"a": true}}"#, #"{"value": 1.5}"#])
    func throwsTypeMismatchForOtherTypes(json: String) {
        let error = #expect(throws: DecodingError.self) { try decode(json) }
        guard case .typeMismatch = error else {
            Issue.record("Expected typeMismatch, got \(String(describing: error))")
            return
        }
    }
}
#endif
