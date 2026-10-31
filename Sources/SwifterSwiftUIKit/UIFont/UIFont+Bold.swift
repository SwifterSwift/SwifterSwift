// UIFont+Bold.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIFont {
    /// SwifterSwift: The bold version of the font, keeping its family, size and other traits.
    ///
    /// The bold trait is added to the font's existing symbolic traits, so an italic font becomes bold italic. Calling
    /// `withSymbolicTraits(.traitBold)` directly replaces the traits instead and drops italic. If the font's family has
    /// no bold face, the font is returned unchanged.
    ///
    /// ```swift
    /// let body = UIFont.preferredFont(forTextStyle: .body)
    /// body.bold.fontDescriptor.symbolicTraits.contains(.traitBold)  // true
    /// body.italic.bold.fontDescriptor.symbolicTraits.contains(.traitItalic)  // true
    /// ```
    var bold: UIFont {
        let traits = fontDescriptor.symbolicTraits.union(.traitBold)
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
#endif
