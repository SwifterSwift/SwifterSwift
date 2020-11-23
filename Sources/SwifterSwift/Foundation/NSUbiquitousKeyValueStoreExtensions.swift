// NSUbiquitousKeyValueStoreExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(Foundation) && !os(Linux)
import Foundation

// MARK: - Methods

public extension NSUbiquitousKeyValueStore {
    /// SwifterSwift: URL from NSUbiquitousKeyValueStore.
    ///
    /// - Parameter forKey: key to find URL for.
    /// - Returns: URL object for key (if exists).
    func url(forKey key: String) -> URL? {
        return URL(string: object(forKey: key) as? String)
    }
}

#endif
