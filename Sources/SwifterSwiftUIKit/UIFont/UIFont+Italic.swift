// UIFont+Italic.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIFont {
    /// SwifterSwift: The italic version of the font, keeping its family, size and other traits.
    ///
    /// The italic trait is added to the font's existing symbolic traits, so a bold font becomes bold italic. Calling
    /// `withSymbolicTraits(.traitItalic)` directly replaces the traits instead and drops bold. If the font's family has
    /// no italic face, the font is returned unchanged. So are text-style fonts on tvOS 26, which can't take the trait.
    ///
    /// ```swift
    /// let body = UIFont.preferredFont(forTextStyle: .body)
    /// body.italic.fontDescriptor.symbolicTraits.contains(.traitItalic)  // true
    /// body.bold.italic.fontDescriptor.symbolicTraits.contains(.traitBold)  // true
    /// ```
    var italic: UIFont {
        let traits = fontDescriptor.symbolicTraits.union(.traitItalic)
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        let font = UIFont(descriptor: descriptor, size: 0)
        return font.fontDescriptor.symbolicTraits.contains(.traitItalic) ? font : self
    }
}
#endif
