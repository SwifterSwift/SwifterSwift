// FileManagerExtensions.swift - Copyright 2025 SwifterSwift

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

    /// SwifterSwift: Read a JSON object from a file at a given path.
    ///
    /// The returned value can be a dictionary (`[String: Any]`), an array (`[Any]`),
    /// or any other valid JSON fragment depending on the file contents.
    ///
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    /// - Returns: The deserialized JSON object.
    func jsonObjectFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> Any {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try JSONSerialization.jsonObject(with: data, options: readingOptions)
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

    /// SwifterSwift: Read a JSON object from a file with a given filename.
    ///
    /// The returned value can be a dictionary (`[String: Any]`), an array (`[Any]`),
    /// or any other valid JSON fragment depending on the file contents.
    ///
    /// - Parameters:
    ///   - filename: File to read.
    ///   - bundleClass: Bundle where the file is associated.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    /// - Returns: The deserialized JSON object, or `nil` if the file was not found.
    func jsonObjectFromFile(
        withFilename filename: String,
        at bundleClass: AnyClass? = nil,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> Any? {
        // https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift

        // To handle cases that provided filename has an extension
        let name = filename.components(separatedBy: ".")[0]
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main

        if let path = bundle.path(forResource: name, ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONSerialization.jsonObject(with: data, options: readingOptions)
        }

        return nil
    }
    #endif

    /// SwifterSwift: Creates a unique directory for saving temporary files. The directory can be used to create
    /// multiple temporary files used for a common purpose.
    ///
    ///     let tempDirectory = try fileManager.createTemporaryDirectory()
    ///     let tempFile1URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///     let tempFile2URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///
    /// - Throws: An error if a temporary directory cannot be found or created.
    /// - Returns: A URL to a new directory for saving temporary files.
    func createTemporaryDirectory() throws -> URL {
        try url(for: .itemReplacementDirectory,
                in: .userDomainMask,
                appropriateFor: temporaryDirectory,
                create: true)
    }
}

#endif
