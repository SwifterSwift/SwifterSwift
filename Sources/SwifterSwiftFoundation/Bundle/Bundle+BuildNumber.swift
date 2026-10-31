// Bundle+BuildNumber.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Bundle {
    /// SwifterSwift: The build number of the bundle, such as `"1042"`.
    ///
    /// Reads `CFBundleVersion`, which is the **Build** field in Xcode. For the release version shown to users, read
    /// `CFBundleShortVersionString` instead.
    ///
    /// ```swift
    /// Bundle.main.buildNumber  // "1042"
    /// ```
    ///
    /// Returns `nil` if the bundle doesn't declare a build number, or if it's empty.
    var buildNumber: String? {
        guard let build = object(forInfoDictionaryKey: "CFBundleVersion") as? String, !build.isEmpty else { return nil }
        return build
    }
}
#endif
