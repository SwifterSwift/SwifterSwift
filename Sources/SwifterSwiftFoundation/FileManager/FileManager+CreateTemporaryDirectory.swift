// FileManager+CreateTemporaryDirectory.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension FileManager {
    /// SwifterSwift: Creates a new, empty, uniquely named directory for temporary files.
    ///
    /// Each call creates a different directory inside the file manager's `temporaryDirectory`, so related temporary
    /// files can live together and be removed with a single `removeItem(at:)`. It asks for an
    /// `.itemReplacementDirectory`, the same mechanism `replaceItemAt(_:withItemAt:)` uses, which is easy to miss in
    /// the `url(for:in:appropriateFor:create:)` API. The system may purge temporary files, but you should remove the
    /// directory yourself when you're done with it.
    ///
    /// ```swift
    /// let directory = try FileManager.default.createTemporaryDirectory()
    /// let fileURL = directory.appending(path: "export.json")
    /// try Data("{}".utf8).write(to: fileURL)
    /// // ...
    /// try FileManager.default.removeItem(at: directory)
    /// ```
    ///
    /// - Returns: The URL of the new directory.
    /// - Throws: An error if the directory can't be created.
    func createTemporaryDirectory() throws -> URL {
        try url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: temporaryDirectory, create: true)
    }
}
#endif
