// KeyedDecodingContainer+DecodeBoolAsIntOrString.swift - Copyright 2026 SwifterSwift

public extension KeyedDecodingContainer {
    /// SwifterSwift: Decodes a Boolean that may be encoded as a Boolean, an integer or a string.
    ///
    /// Use it for APIs that send flags as `true`, `1` or `"yes"`. Only unambiguous values are accepted:
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
    ///     let isEnabled: Bool
    ///
    ///     init(from decoder: any Decoder) throws {
    ///         let container = try decoder.container(keyedBy: CodingKeys.self)
    ///         isEnabled = try container.decodeBoolAsIntOrString(forKey: .isEnabled)
    ///     }
    ///
    ///     enum CodingKeys: CodingKey { case isEnabled }
    /// }
    ///
    /// // {"isEnabled": 1}, {"isEnabled": "YES"} and {"isEnabled": true} all decode to true.
    /// // {"isEnabled": 2} throws DecodingError.dataCorrupted.
    /// ```
    ///
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: The decoded Boolean.
    /// - Throws: `DecodingError.dataCorrupted` if the value is an integer or a string with no clear Boolean meaning.
    ///   Otherwise, the error the decoder throws for a `Bool`: `DecodingError.keyNotFound` if the key is missing, and
    ///   `DecodingError.typeMismatch` (or `valueNotFound`, depending on the decoder) for null and other types.
    func decodeBoolAsIntOrString(forKey key: Key) throws -> Bool {
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
        // Decode again as a Boolean to throw the decoder's own error for a missing key, null or another type.
        return try decode(Bool.self, forKey: key)
    }
}
