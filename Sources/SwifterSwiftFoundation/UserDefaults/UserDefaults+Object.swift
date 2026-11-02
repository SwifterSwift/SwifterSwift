// UserDefaults+Object.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension UserDefaults {
    /// SwifterSwift: Returns the value of the given type decoded from the JSON data stored for the given key.
    ///
    /// It reads values written by `set(object:forKey:encoder:)`, or any JSON stored as `Data`. When there's no data
    /// for the key, including when the key holds a value that isn't `Data`, the result is `nil`. When there is data
    /// but it doesn't decode as `type`, the decoding error is thrown instead of being hidden behind `nil`.
    ///
    /// ```swift
    /// struct Profile: Codable { var name: String }
    ///
    /// let defaults = UserDefaults.standard
    /// defaults.set(try JSONEncoder().encode(Profile(name: "Taylor")), forKey: "profile")
    /// try defaults.object(Profile.self, forKey: "profile")  // Profile(name: "Taylor")
    /// try defaults.object(Profile.self, forKey: "unknown")  // nil
    /// ```
    ///
    /// UserDefaults is a required-reason API: an app that uses this method must declare it in its privacy manifest.
    ///
    /// - Parameters:
    ///   - type: The type of the value to decode.
    ///   - key: The key to read.
    ///   - decoder: The decoder to use. The default is a new `JSONDecoder`.
    /// - Returns: The decoded value, or `nil` if there's no data for `key`.
    /// - Throws: The decoder's error if the stored data doesn't decode as `type`.
    /// - Complexity: O(*n*), where *n* is the size of the stored data.
    func object<Value: Decodable>(
        _ type: Value.Type,
        forKey key: String,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> Value? {
        guard let data = data(forKey: key) else { return nil }
        return try decoder.decode(type, from: data)
    }
}
#endif
