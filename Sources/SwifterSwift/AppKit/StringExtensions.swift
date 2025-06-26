// StringExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension String {
    // String localization
    var localize: String {
        return NSLocalizedString(self, tableName: nil, bundle: .main, value: self, comment: self)
    }
    
    // Remove spaces and line breaks before and after the string, but not spaces in the middle
    func trimmingWhitespaces() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}

#endif
