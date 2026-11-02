// NSAttributedString+Bolded.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import Foundation
import UIKit

public extension NSAttributedString {
    /// SwifterSwift: Returns a copy of the attributed string with the bold trait added to the font of every run.
    ///
    /// Each run keeps its font family, size and other traits, so italic text becomes bold italic and a custom font
    /// becomes its own bold face. Text that has no font gets `defaultFont`, made bold. Text that is already bold keeps
    /// its font, and text whose font family has no bold face (such as Zapfino or Apple Color Emoji) keeps its font
    /// unchanged, as do text-style fonts on tvOS 26, which can't take the trait. Other attributes are kept, and the
    /// original string isn't modified.
    ///
    /// ```swift
    /// let text = NSMutableAttributedString(string: "Hello ", attributes: [.font: UIFont(name: "Georgia", size: 20)!])
    /// text.append(NSAttributedString(string: "world"))
    /// let bold = text.bolded()
    /// // "Hello " is Georgia-Bold 20, "world" is the bold body font.
    /// ```
    ///
    /// - Parameter defaultFont: The font to make bold for text that has no font attribute. The default is the
    ///   preferred font for the `.body` text style.
    /// - Returns: A copy of the string with every run in a bold version of its font.
    /// - Complexity: O(*n*), where *n* is the number of font runs in the string.
    func bolded(defaultFont: UIFont = .preferredFont(forTextStyle: .body)) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        enumerateAttribute(.font, in: NSRange(location: 0, length: length), options: []) { value, range, _ in
            let font = value as? UIFont ?? defaultFont
            var boldFont = font
            let traits = font.fontDescriptor.symbolicTraits
            if !traits.contains(.traitBold),
                let descriptor = font.fontDescriptor.withSymbolicTraits(traits.union(.traitBold))
            {
                let candidate = UIFont(descriptor: descriptor, size: 0)
                if candidate.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    boldFont = candidate
                }
            }
            result.addAttribute(.font, value: boldFont, range: range)
        }
        return result
    }
}
#endif
