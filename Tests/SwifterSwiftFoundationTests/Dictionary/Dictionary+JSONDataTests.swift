// Dictionary+JSONDataTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DictionaryJSONDataTests {
    static func text(_ data: Data) -> String {
        String(decoding: data, as: UTF8.self)
    }

    @Test
    func encodesAFlatDictionary() throws {
        let dictionary: [String: Any] = ["name": "Taylor", "age": 41, "admin": true, "manager": NSNull()]
        let data = try dictionary.jsonData(options: .sortedKeys)
        #expect(Self.text(data) == #"{"admin":true,"age":41,"manager":null,"name":"Taylor"}"#)
    }

    @Test
    func encodesNestedContainers() throws {
        let dictionary: [String: Any] = ["user": ["name": "Zoë", "tags": ["swift", 7, false]], "ids": [Int]()]
        let data = try dictionary.jsonData(options: .sortedKeys)
        #expect(Self.text(data) == #"{"ids":[],"user":{"name":"Zoë","tags":["swift",7,false]}}"#)
    }

    @Test
    func encodesTypedDictionaries() throws {
        #expect(Self.text(try ["b": 2, "a": 1].jsonData(options: .sortedKeys)) == #"{"a":1,"b":2}"#)
        #expect(Self.text(try ["list": [1.5, -2.5]].jsonData()) == #"{"list":[1.5,-2.5]}"#)
        let optionals: [String: Int?] = ["a": nil, "b": 1]
        #expect(Self.text(try optionals.jsonData(options: .sortedKeys)) == #"{"a":null,"b":1}"#)
    }

    @Test
    func encodesAnEmptyDictionary() throws {
        #expect(Self.text(try [String: Int]().jsonData()) == "{}")
        #expect(Self.text(try ["": ""].jsonData()) == #"{"":""}"#)
    }

    @Test
    func keepsUnicodeAndEscapesControlCharacters() throws {
        let dictionary = ["text": "Zoë 🧑‍💻 🇯🇵 e\u{301} \"quoted\"\n\t"]
        let data = try dictionary.jsonData()
        let decoded = try #require(try JSONSerialization.jsonObject(with: data) as? [String: String])
        #expect(decoded == dictionary)
        #expect(Self.text(data).contains("🧑‍💻 🇯🇵"))
        #expect(Self.text(data).contains(#"\"quoted\"\n\t"#))
    }

    @Test
    func encodesExtremeIntegers() throws {
        let dictionary: [String: Any] = ["max": Int64.max, "min": Int64.min, "umax": UInt64.max]
        let data = try dictionary.jsonData(options: .sortedKeys)
        #expect(
            Self.text(data) == #"{"max":9223372036854775807,"min":-9223372036854775808,"umax":18446744073709551615}"#)
    }

    @Test
    func roundTripsFiniteDoubles() throws {
        let values = [0.1, -0.0, 1e300, -1e-300, Double.greatestFiniteMagnitude, Double.leastNonzeroMagnitude]
        let data = try ["values": values].jsonData()
        let decoded = try #require(try JSONSerialization.jsonObject(with: data) as? [String: [Double]])
        #expect(decoded["values"] == values)
    }

    @Test
    func appliesTheWritingOptions() throws {
        let dictionary: [String: Any] = ["path": "a/b", "list": [1, 2]]
        #expect(Self.text(try dictionary.jsonData(options: .sortedKeys)) == #"{"list":[1,2],"path":"a\/b"}"#)
        let unescaped = try dictionary.jsonData(options: [.sortedKeys, .withoutEscapingSlashes])
        #expect(Self.text(unescaped) == #"{"list":[1,2],"path":"a/b"}"#)
        let pretty = try dictionary.jsonData(options: [.sortedKeys, .prettyPrinted])
        #expect(Self.text(pretty).contains("\n"))
        let compact = try JSONSerialization.jsonObject(with: pretty) as? [String: Any]
        #expect(compact?["path"] as? String == "a/b")
    }

    /// Dictionaries holding a value that JSON can't represent. `JSONSerialization` would raise an Objective-C exception
    /// for each of them.
    static func invalidDictionaries() -> [(label: String, dictionary: [String: Any])] {
        [
            ("date", ["date": Date(timeIntervalSince1970: 0)]),
            ("url", ["url": URL(fileURLWithPath: "/tmp")]),
            ("data", ["data": Data([1, 2, 3])]),
            ("nan", ["nan": Double.nan]),
            ("infinity", ["infinity": Double.infinity]),
            ("negative infinity", ["negativeInfinity": -Float.infinity]),
            ("nested date", ["nested": ["deeper": [1, Date(timeIntervalSince1970: 0)]]]),
            ("integer keys", ["intKeys": [1: "one"]]),
            ("tuple", ["tuple": (1, 2)]),
            ("object", ["object": NSObject()])
        ]
    }

    @Test
    func throwsInsteadOfCrashingForValuesJSONCannotRepresent() throws {
        for (label, dictionary) in Self.invalidDictionaries() {
            let error = try #require(throws: EncodingError.self, "\(label)") { try dictionary.jsonData() }
            guard case .invalidValue(_, let context) = error else {
                Issue.record("Expected EncodingError.invalidValue for \(label), got \(error)")
                continue
            }
            #expect(context.codingPath.isEmpty, "\(label)")
            #expect(context.debugDescription.contains("valid JSON object"), "\(label)")
        }
    }

    @Test
    func throwsForAnEncodableStruct() throws {
        struct Point: Encodable {
            var x: Int
        }
        #expect(throws: EncodingError.self) { try ["point": Point(x: 1)].jsonData() }
    }
}
#endif
