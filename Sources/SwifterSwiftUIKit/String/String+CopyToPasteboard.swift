// String+CopyToPasteboard.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(tvOS) && !os(watchOS)
import UIKit

public extension String {
    /// SwifterSwift: Replaces the contents of a pasteboard with the string, as plain text.
    ///
    /// Everything else on the pasteboard, including other representations of whatever was copied before, is removed.
    /// The method only writes to the pasteboard, so it never shows the alert that asks the user for permission to
    /// paste.
    ///
    /// Unlike the AppKit version, it doesn't return whether the write succeeded: `UIPasteboard` doesn't report it, and
    /// reading the general pasteboard back to check would ask the user for permission to paste.
    ///
    /// ```swift
    /// "Hello, World!".copyToPasteboard()
    /// UIPasteboard.general.string  // "Hello, World!"
    /// ```
    ///
    /// - Parameter pasteboard: The pasteboard to copy the string to. The default is the general pasteboard, which
    ///   backs Copy and Paste.
    func copyToPasteboard(_ pasteboard: UIPasteboard = .general) {
        pasteboard.string = self
    }
}
#endif
