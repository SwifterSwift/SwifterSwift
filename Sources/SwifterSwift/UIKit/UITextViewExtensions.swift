// UITextViewExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UITextView {
    /// SwifterSwift: Clear text.
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// SwifterSwift: Scroll to the bottom of text view.
    func scrollToBottom() {
        let range = NSRange(location: (text as NSString).length - 1, length: 1)
        scrollRangeToVisible(range)
    }

    /// SwifterSwift: Scroll to the top of text view.
    func scrollToTop() {
        let range = NSRange(location: 0, length: 1)
        scrollRangeToVisible(range)
    }

    /// SwifterSwift: Wrap to the content (Text / Attributed Text).
    func wrapToContent() {
        isScrollEnabled = false
        contentInset = .zero
        scrollIndicatorInsets = .zero
        contentOffset = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }
}

#endif
