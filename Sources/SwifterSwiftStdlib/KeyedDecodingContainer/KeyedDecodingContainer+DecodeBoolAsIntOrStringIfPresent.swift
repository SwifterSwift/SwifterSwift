// KeyedDecodingContainer+DecodeBoolAsIntOrStringIfPresent.swift - Copyright 2026 SwifterSwift

public extension KeyedDecodingContainer {
    /// SwifterSwift: Decodes a Boolean that may be encoded as a Boolean, an integer or a string, if present.
    ///
    /// Like `decodeIfPresent(_:forKey:)`, it returns `nil` when the key is missing or its value is null. Otherwise
    /// only unambiguous values are accepted:
    ///
    /// - Booleans: `true` and `false`.
    /// - Integers: `1` and `0`.
    /// - Strings, ignoring case: `"true"`, `"yes"` and `"1"`, or `"false"`, `"no"` and `"0"`.
    ///
    /// Anything else, such as `2`, `"maybe"` or `" true"`, throws `DecodingError.dataCorrupted` instead of being
    /// guessed.
    ///
    /// ```swift
    /// struct Settings: Decodable {
    ///     let isEnabled: Bool?
    ///
    ///     init(from decoder: any Decoder) throws {
    ///         let container = try decoder.container(keyedBy: CodingKeys.self)
    ///         isEnabled = try container.decodeBoolAsIntOrStringIfPresent(forKey: .isEnabled)
    ///     }
    ///
    ///     enum CodingKeys: CodingKey { case isEnabled }
    /// }
    ///
    /// // {"isEnabled": "no"} decodes to false; {} and {"isEnabled": null} decode to nil.
    /// // {"isEnabled": "maybe"} throws DecodingError.dataCorrupted.
    /// ```
    ///
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: The decoded Boolean, or `nil` if the key is missing or its value is null.
    /// - Throws: `DecodingError.dataCorrupted` if the value is an integer or a string with no clear Boolean meaning,
    ///   and the decoder's error for a `Bool`, typically `DecodingError.typeMismatch`, for any other type.
    func decodeBoolAsIntOrStringIfPresent(forKey key: Key) throws -> Bool? {
        guard contains(key), try !decodeNil(forKey: key) else { return nil }
        if let bool = try? decode(Bool.self, forKey: key) {
            return bool
        }
        if let integer = try? decode(Int.self, forKey: key) {
            switch integer {
            case 1: return true
            case 0: return false
            default:
                throw DecodingError.dataCorruptedError(
                    forKey: key,
                    in: self,
                    debugDescription: "Expected 0 or 1 for a Boolean, found \(integer)."
                )
            }
        }
        if let string = try? decode(String.self, forKey: key) {
            switch string.lowercased() {
            case "true", "yes", "1": return true
            case "false", "no", "0": return false
            default:
                throw DecodingError.dataCorruptedError(
                    forKey: key,
                    in: self,
                    debugDescription: "Expected true, false, yes, no, 1 or 0 for a Boolean, found \"\(string)\"."
                )
            }
        }
        // Decode again as a Boolean to throw the decoder's own type mismatch error.
        return try decode(Bool.self, forKey: key)
    }
}
