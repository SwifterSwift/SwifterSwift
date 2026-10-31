// UITextView+WrapToContent.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UITextView {
    /// SwifterSwift: Removes the text view's insets and padding and resizes it to fit its text.
    ///
    /// Scrolling is turned off; the content inset, scroll indicator insets, text container inset and line fragment
    /// padding are set to zero; the content offset is reset; then `sizeToFit()` resizes the text view around its text,
    /// with no extra margins, so the text lines up with labels around it.
    ///
    /// The text is laid out at the text view's current width: its height becomes the height of all the lines, and its
    /// width shrinks to the widest line when the text is narrower than the text view. A text view with no text keeps
    /// the height of one line and gets a width of `0`.
    ///
    /// The text view isn't resized again when its text changes later. With scrolling off, it reports the size of its
    /// text as its intrinsic content size, so Auto Layout can size it from there on.
    ///
    /// ```swift
    /// let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    /// textView.text = "A long text that wraps over several lines"
    /// textView.wrapToContent()
    /// textView.textContainerInset  // .zero
    /// textView.bounds.height  // the height of the wrapped lines
    /// ```
    func wrapToContent() {
        isScrollEnabled = false
        contentInset = .zero
        verticalScrollIndicatorInsets = .zero
        horizontalScrollIndicatorInsets = .zero
        contentOffset = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }
}
#endif
