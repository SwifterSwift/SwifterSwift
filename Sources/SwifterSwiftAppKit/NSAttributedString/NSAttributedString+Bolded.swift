// NSAttributedString+Bolded.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation

public extension NSAttributedString {
    /// SwifterSwift: Returns a copy of the attributed string with the bold trait added to the font of every run.
    ///
    /// Each run keeps its font family, size and other traits, so italic text becomes bold italic and a custom font
    /// becomes its own bold face. Text that has no font gets `defaultFont`, made bold. Text that is already bold keeps
    /// its font, and text whose font has no bold face keeps its font unchanged. That includes families with a single
    /// face (such as Zapfino or Apple Color Emoji) and system fonts created with an explicit weight, such as
    /// `NSFont.systemFont(ofSize: 13, weight: .light)`. Other attributes are kept, and the original string isn't
    /// modified.
    ///
    /// ```swift
    /// let text = NSMutableAttributedString(string: "Hello ", attributes: [.font: NSFont(name: "Georgia", size: 20)!])
    /// text.append(NSAttributedString(string: "world"))
    /// let bold = text.bolded()
    /// // "Hello " is Georgia-Bold 20, "world" is the bold system font at the standard size.
    /// ```
    ///
    /// - Parameter defaultFont: The font to make bold for text that has no font attribute. The default is the system
    ///   font at the standard size.
    /// - Returns: A copy of the string with every run in a bold version of its font.
    /// - Complexity: O(*n*), where *n* is the number of font runs in the string.
    func bolded(defaultFont: NSFont = .systemFont(ofSize: NSFont.systemFontSize)) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        enumerateAttribute(.font, in: NSRange(location: 0, length: length), options: []) { value, range, _ in
            let font = value as? NSFont ?? defaultFont
            var boldFont = font
            let traits = font.fontDescriptor.symbolicTraits
            if !traits.contains(.bold),
                let candidate = NSFont(
                    descriptor: font.fontDescriptor.withSymbolicTraits(traits.union(.bold)), size: 0),
                candidate.fontDescriptor.symbolicTraits.contains(.bold)
            {
                boldFont = candidate
            }
            result.addAttribute(.font, value: boldFont, range: range)
        }
        return result
    }
}
#endif
