// Dictionary+JSONStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DictionaryJSONStringTests {
    @Test
    func encodesAFlatDictionary() throws {
        let dictionary: [String: Any] = ["name": "Taylor", "age": 41, "admin": true, "manager": NSNull()]
        #expect(
            try dictionary.jsonString(options: .sortedKeys)
                == #"{"admin":true,"age":41,"manager":null,"name":"Taylor"}"#)
    }

    @Test
    func encodesNestedContainers() throws {
        let dictionary: [String: Any] = ["user": ["name": "Zoë", "tags": ["swift", 7, false]], "ids": [Int]()]
        #expect(
            try dictionary.jsonString(options: .sortedKeys)
                == #"{"ids":[],"user":{"name":"Zoë","tags":["swift",7,false]}}"#)
    }

    @Test
    func encodesTypedDictionaries() throws {
        #expect(try ["b": 2, "a": 1].jsonString(options: .sortedKeys) == #"{"a":1,"b":2}"#)
        #expect(try ["list": [1.5, -2.5]].jsonString() == #"{"list":[1.5,-2.5]}"#)
        let optionals: [String: Int?] = ["a": nil, "b": 1]
        #expect(try optionals.jsonString(options: .sortedKeys) == #"{"a":null,"b":1}"#)
    }

    @Test
    func encodesAnEmptyDictionary() throws {
        #expect(try [String: Int]().jsonString() == "{}")
        #expect(try ["": ""].jsonString() == #"{"":""}"#)
    }

    @Test
    func keepsUnicodeAndEscapesControlCharacters() throws {
        let dictionary = ["text": "Zoë 🧑‍💻 🇯🇵 e\u{301} \"quoted\"\n\t\u{0}"]
        let string = try dictionary.jsonString()
        #expect(string == #"{"text":"Zoë 🧑‍💻 🇯🇵 e\#u{301} \"quoted\"\n\t\u0000"}"#)
        let decoded = try JSONSerialization.jsonObject(with: Data(string.utf8)) as? [String: String]
        #expect(decoded == dictionary)
    }

    @Test
    func encodesExtremeIntegers() throws {
        let dictionary: [String: Any] = ["max": Int64.max, "min": Int64.min, "umax": UInt64.max]
        #expect(
            try dictionary.jsonString(options: .sortedKeys)
                == #"{"max":9223372036854775807,"min":-9223372036854775808,"umax":18446744073709551615}"#)
    }

    @Test
    func appliesTheWritingOptions() throws {
        let dictionary: [String: Any] = ["path": "a/b", "list": [1, 2]]
        #expect(try dictionary.jsonString(options: .sortedKeys) == #"{"list":[1,2],"path":"a\/b"}"#)
        #expect(
            try dictionary.jsonString(options: [.sortedKeys, .withoutEscapingSlashes])
                == #"{"list":[1,2],"path":"a/b"}"#)
        let pretty = try dictionary.jsonString(options: [.sortedKeys, .prettyPrinted])
        #expect(pretty.contains("\n"))
        let decoded = try JSONSerialization.jsonObject(with: Data(pretty.utf8)) as? [String: Any]
        #expect(decoded?["path"] as? String == "a/b")
        #expect(decoded?["list"] as? [Int] == [1, 2])
    }

    @Test
    func matchesTheUTF8OfJSONData() throws {
        let dictionary: [String: Any] = ["name": "Zoë 🧑‍💻", "values": [1, 2.5, true]]
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .sortedKeys)
        #expect(Data(try dictionary.jsonString(options: .sortedKeys).utf8) == data)
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
            let error = try #require(throws: EncodingError.self, "\(label)") { try dictionary.jsonString() }
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
        #expect(throws: EncodingError.self) { try ["point": Point(x: 1)].jsonString() }
    }
}
#endif
