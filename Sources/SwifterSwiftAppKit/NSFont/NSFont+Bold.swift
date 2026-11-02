// NSFont+Bold.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSFont {
    /// SwifterSwift: The bold version of the font, keeping its family, size and other traits.
    ///
    /// The bold trait is added to the font's existing symbolic traits, so an italic font becomes bold italic. Calling
    /// `withSymbolicTraits(.bold)` directly replaces the traits instead and drops italic. If the font's family has no
    /// bold face, the font is returned unchanged.
    ///
    /// Unlike `NSFontManager.convert(_:toHaveTrait:)`, this doesn't go through the shared font manager.
    ///
    /// ```swift
    /// let font = NSFont.systemFont(ofSize: 13)
    /// font.bold.fontDescriptor.symbolicTraits.contains(.bold)  // true
    /// NSFont(name: "Helvetica-Oblique", size: 13)?.bold.fontName  // "Helvetica-BoldOblique"
    /// ```
    var bold: NSFont {
        let traits = fontDescriptor.symbolicTraits.union(.bold)
        return NSFont(descriptor: fontDescriptor.withSymbolicTraits(traits), size: 0) ?? self
    }
}
#endif
