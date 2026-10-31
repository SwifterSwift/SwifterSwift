// KeyedDecodingContainer+DecodeBoolAsIntOrStringIfPresentTests.swift - Copyright 2026 SwifterSwift

// The extension itself needs only the standard library; the tests use Foundation's `JSONDecoder` to drive it.
#if canImport(Foundation)
import Foundation
import SwifterSwiftStdlib
import Testing

struct KeyedDecodingContainerDecodeBoolAsIntOrStringIfPresentTests {
    struct Flag: Decodable {
        let value: Bool?

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            value = try container.decodeBoolAsIntOrStringIfPresent(forKey: .value)
        }

        enum CodingKeys: CodingKey {
            case value
        }
    }

    func decode(_ json: String) throws -> Bool? {
        try JSONDecoder().decode(Flag.self, from: Data(json.utf8)).value
    }

    @Test(arguments: [
        (#"{"value": true}"#, true),
        (#"{"value": false}"#, false),
        (#"{"value": 1}"#, true),
        (#"{"value": 0}"#, false),
        (#"{"value": "TRUE"}"#, true),
        (#"{"value": "false"}"#, false),
        (#"{"value": "Yes"}"#, true),
        (#"{"value": "no"}"#, false),
        (#"{"value": "1"}"#, true),
        (#"{"value": "0"}"#, false)
    ])
    func decodesUnambiguousValues(json: String, expected: Bool) throws {
        #expect(try decode(json) == expected)
    }

    @Test(arguments: ["{}", #"{"value": null}"#, #"{"other": true}"#])
    func returnsNilForAMissingKeyOrNull(json: String) throws {
        #expect(try decode(json) == nil)
    }

    @Test(arguments: [
        #"{"value": 2}"#, #"{"value": -1}"#, #"{"value": "Yolo"}"#, #"{"value": ""}"#, #"{"value": " no"}"#
    ])
    func throwsDataCorruptedForAmbiguousValues(json: String) {
        let error = #expect(throws: DecodingError.self) { try decode(json) }
        guard case .dataCorrupted(let context) = error else {
            Issue.record("Expected dataCorrupted, got \(String(describing: error))")
            return
        }
        #expect(context.codingPath.map(\.stringValue) == ["value"])
    }

    @Test(arguments: [#"{"value": [true]}"#, #"{"value": {}}"#, #"{"value": 0.5}"#])
    func throwsTypeMismatchForOtherTypes(json: String) {
        let error = #expect(throws: DecodingError.self) { try decode(json) }
        guard case .typeMismatch = error else {
            Issue.record("Expected typeMismatch, got \(String(describing: error))")
            return
        }
    }
}
#endif
