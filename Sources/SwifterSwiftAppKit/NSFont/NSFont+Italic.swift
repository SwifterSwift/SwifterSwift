// NSFont+Italic.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSFont {
    /// SwifterSwift: The italic version of the font, keeping its family, size and other traits.
    ///
    /// The italic trait is added to the font's existing symbolic traits, so a bold font becomes bold italic. Calling
    /// `withSymbolicTraits(.italic)` directly replaces the traits instead and drops bold. If the font's family has no
    /// italic face, the font is returned unchanged.
    ///
    /// Unlike `NSFontManager.convert(_:toHaveTrait:)`, this doesn't go through the shared font manager.
    ///
    /// ```swift
    /// let font = NSFont.systemFont(ofSize: 13)
    /// font.italic.fontDescriptor.symbolicTraits.contains(.italic)  // true
    /// NSFont(name: "Helvetica-Bold", size: 13)?.italic.fontName  // "Helvetica-BoldOblique"
    /// ```
    var italic: NSFont {
        let traits = fontDescriptor.symbolicTraits.union(.italic)
        return NSFont(descriptor: fontDescriptor.withSymbolicTraits(traits), size: 0) ?? self
    }
}
#endif
