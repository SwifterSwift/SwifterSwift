// NSAttributedString+Italicized.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation

public extension NSAttributedString {
    /// SwifterSwift: Returns a copy of the attributed string with the italic trait added to the font of every run.
    ///
    /// Each run keeps its font family, size and other traits, so bold text becomes bold italic and a custom font
    /// becomes its own italic face. Text that has no font gets `defaultFont`, made italic. Text that is already italic
    /// keeps its font, and text whose font family has no italic face (such as Zapfino or Apple Color Emoji) keeps its
    /// font unchanged. Other attributes are kept, and the original string isn't modified.
    ///
    /// ```swift
    /// let text = NSMutableAttributedString(string: "Hello ", attributes: [.font: NSFont(name: "Georgia", size: 20)!])
    /// text.append(NSAttributedString(string: "world"))
    /// let italic = text.italicized()
    /// // "Hello " is Georgia-Italic 20, "world" is the italic system font at the standard size.
    /// ```
    ///
    /// - Parameter defaultFont: The font to make italic for text that has no font attribute. The default is the system
    ///   font at the standard size.
    /// - Returns: A copy of the string with every run in an italic version of its font.
    /// - Complexity: O(*n*), where *n* is the number of font runs in the string.
    func italicized(defaultFont: NSFont = .systemFont(ofSize: NSFont.systemFontSize)) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        enumerateAttribute(.font, in: NSRange(location: 0, length: length), options: []) { value, range, _ in
            let font = value as? NSFont ?? defaultFont
            var italicFont = font
            let traits = font.fontDescriptor.symbolicTraits
            if !traits.contains(.italic),
                let candidate = NSFont(
                    descriptor: font.fontDescriptor.withSymbolicTraits(traits.union(.italic)), size: 0),
                candidate.fontDescriptor.symbolicTraits.contains(.italic)
            {
                italicFont = candidate
            }
            result.addAttribute(.font, value: italicFont, range: range)
        }
        return result
    }
}
#endif
