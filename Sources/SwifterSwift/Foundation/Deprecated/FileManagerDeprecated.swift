// FileManagerDeprecated.swift - Copyright 2025 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension FileManager {
    /// SwifterSwift: Read from a JSON file at a given path.
    ///
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    /// - Returns: Optional dictionary.
    @available(*, deprecated, renamed: "jsonObjectFromFile(atPath:readingOptions:)")
    func jsonFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        try jsonObjectFromFile(atPath: path, readingOptions: readingOptions) as? [String: Any]
    }

    #if !os(Linux) && !os(Android)
    /// SwifterSwift: Read from a JSON file with a given filename.
    ///
    /// - Parameters:
    ///   - filename: File to read.
    ///   - bundleClass: Bundle where the file is associated.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    /// - Returns: Optional dictionary.
    @available(*, deprecated, renamed: "jsonObjectFromFile(withFilename:at:readingOptions:)")
    func jsonFromFile(
        withFilename filename: String,
        at bundleClass: AnyClass? = nil,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        try jsonObjectFromFile(withFilename: filename, at: bundleClass, readingOptions: readingOptions) as? [String: Any]
    }
    #endif
}

#endif
