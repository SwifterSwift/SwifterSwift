// UserDefaultsExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation) && !os(Linux)
import Foundation

// MARK: - Methods

public extension UserDefaults {
    /// SwifterSwift: get object from UserDefaults by using subscript.
    ///
    /// - Parameter key: key in the current user's defaults database.
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// SwifterSwift: Float from UserDefaults.
    ///
    /// - Parameter key: key to find float for.
    /// - Returns: Float object for key (if exists).
    func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }

    /// SwifterSwift: Date from UserDefaults.
    ///
    /// - Parameter key: key to find date for.
    /// - Returns: Date object for key (if exists).
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }

    /// SwifterSwift: Retrieves a Codable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Codable object for key (if exists).
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// SwifterSwift: Allows storing of Codable objects to UserDefaults.
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }
}

#endif
