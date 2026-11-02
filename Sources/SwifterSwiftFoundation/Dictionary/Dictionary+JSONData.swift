// Dictionary+JSONData.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Dictionary where Key == String {
    /// SwifterSwift: Returns the dictionary encoded as a JSON object.
    ///
    /// Every value, at any depth, must be a string, a number, a Boolean, `NSNull`, `nil`, or an array or dictionary of
    /// these, with string keys; numbers must be finite. For anything else, such as a `Date`, a `URL`, `Data` or `.nan`,
    /// `JSONSerialization.data(withJSONObject:options:)` raises an Objective-C exception that `try` can't catch, and the
    /// app crashes. This method checks `JSONSerialization.isValidJSONObject(_:)` first and throws instead.
    ///
    /// Dictionaries have no order, so keys can come out in any order; pass `.sortedKeys` for stable output. For
    /// `Encodable` types, `JSONEncoder` is the better fit.
    ///
    /// ```swift
    /// let user: [String: Any] = ["name": "Zoë", "tags": ["swift", "ios"], "age": 30]
    /// String(decoding: try user.jsonData(options: .sortedKeys), as: UTF8.self)
    /// // {"age":30,"name":"Zoë","tags":["swift","ios"]}
    /// try ["joined": Date()].jsonData()  // throws EncodingError.invalidValue
    /// ```
    ///
    /// - Parameter options: The options for writing the JSON, such as `.prettyPrinted` or `.sortedKeys`. The default
    ///   is none.
    /// - Returns: The UTF-8 encoded JSON data.
    /// - Throws: `EncodingError.invalidValue` if the dictionary contains a value that JSON can't represent, or the error
    ///   from `JSONSerialization`.
    /// - Complexity: O(*n*), where *n* is the total number of values in the dictionary and its nested containers.
    func jsonData(options: JSONSerialization.WritingOptions = []) throws -> Data {
        guard JSONSerialization.isValidJSONObject(self) else {
            throw EncodingError.invalidValue(
                self,
                EncodingError.Context(
                    codingPath: [],
                    debugDescription: """
                        The dictionary isn't a valid JSON object. Every value must be a string, a number, a Boolean, \
                        NSNull, nil, or an array or dictionary of these, and numbers must be finite.
                        """
                )
            )
        }
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
}
#endif
