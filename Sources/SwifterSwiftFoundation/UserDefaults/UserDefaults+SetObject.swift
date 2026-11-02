// UserDefaults+SetObject.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension UserDefaults {
    /// SwifterSwift: Stores the given value as JSON data under the given key.
    ///
    /// Property lists can't hold arbitrary types, so the value is encoded to JSON and stored as `Data`; read it back
    /// with `object(_:forKey:decoder:)`. If encoding fails, the error is thrown and the value already stored for the
    /// key is left untouched.
    ///
    /// ```swift
    /// struct Profile: Codable { var name: String }
    ///
    /// let defaults = UserDefaults.standard
    /// try defaults.set(object: Profile(name: "Taylor"), forKey: "profile")
    /// defaults.data(forKey: "profile")  // the JSON {"name":"Taylor"}, as Data
    /// ```
    ///
    /// The `object:` label keeps calls such as `set(5, forKey:)` going to the SDK's `set(_:forKey:)`, which stores
    /// plist values directly. UserDefaults is a required-reason API: an app that uses this method must declare it in
    /// its privacy manifest.
    ///
    /// - Parameters:
    ///   - object: The value to store.
    ///   - key: The key to store the value under.
    ///   - encoder: The encoder to use. The default is a new `JSONEncoder`.
    /// - Throws: The encoder's error if `object` can't be encoded. Nothing is written in that case.
    /// - Complexity: O(*n*), where *n* is the size of the encoded value.
    func set(object: some Encodable, forKey key: String, encoder: JSONEncoder = JSONEncoder()) throws {
        let data = try encoder.encode(object)
        set(data, forKey: key)
    }
}
#endif
