// String+CopyToPasteboard.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension String {
    /// SwifterSwift: Replaces the contents of a pasteboard with the string, as plain text.
    ///
    /// `NSPasteboard` needs its contents cleared before new data can be written, and `setString(_:forType:)` silently
    /// fails if you forget. This method does both steps. Everything else on the pasteboard, including other
    /// representations of whatever was copied before, is removed.
    ///
    /// ```swift
    /// "Hello, World!".copyToPasteboard()
    /// NSPasteboard.general.string(forType: .string)  // "Hello, World!"
    /// ```
    ///
    /// - Parameter pasteboard: The pasteboard to copy the string to. The default is the general pasteboard, which
    ///   backs Copy and Paste.
    /// - Returns: `true` if the string was written to the pasteboard; otherwise, `false`.
    @discardableResult
    func copyToPasteboard(_ pasteboard: NSPasteboard = .general) -> Bool {
        pasteboard.clearContents()
        return pasteboard.setString(self, forType: .string)
    }
}
#endif
