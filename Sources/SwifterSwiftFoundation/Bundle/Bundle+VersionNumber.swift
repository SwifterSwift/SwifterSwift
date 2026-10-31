// Bundle+VersionNumber.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Bundle {
    /// SwifterSwift: The release version number of the bundle, such as `"2.4.1"`.
    ///
    /// Reads `CFBundleShortVersionString`, which is the **Version** field in Xcode and the version shown on the App
    /// Store. For the build number, read `CFBundleVersion` instead.
    ///
    /// ```swift
    /// Bundle.main.versionNumber  // "2.4.1"
    /// ```
    ///
    /// Returns `nil` if the bundle doesn't declare a version number, or if it's empty.
    var versionNumber: String? {
        guard let version = object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, !version.isEmpty
        else { return nil }
        return version
    }
}
#endif
