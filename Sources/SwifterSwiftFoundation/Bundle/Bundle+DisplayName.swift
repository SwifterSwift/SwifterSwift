// Bundle+DisplayName.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Bundle {
    /// SwifterSwift: The user-visible name of the bundle, such as the name shown under an app's icon.
    ///
    /// Reads `CFBundleDisplayName` and falls back to `CFBundleName` when the bundle doesn't set a display name, which
    /// is common for apps whose display name matches their product name. Both values are read with
    /// `object(forInfoDictionaryKey:)`, so a localized name from `InfoPlist.strings` takes precedence.
    ///
    /// ```swift
    /// Bundle.main.displayName  // "SwifterSwift"
    /// ```
    ///
    /// Empty names are treated as missing.
    var displayName: String? {
        for key in ["CFBundleDisplayName", "CFBundleName"] {
            if let name = object(forInfoDictionaryKey: key) as? String, !name.isEmpty {
                return name
            }
        }
        return nil
    }
}
#endif
