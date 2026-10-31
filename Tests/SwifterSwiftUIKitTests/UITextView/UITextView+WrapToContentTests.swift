// UITextView+WrapToContentTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextViewWrapToContentTests {
    let longText = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et \
        dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.
        """

    func makeTextView(text: String) -> UITextView {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        textView.font = .systemFont(ofSize: 17)
        textView.text = text
        textView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0)
        textView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        textView.contentOffset = CGPoint(x: 0, y: 30)
        return textView
    }

    func lineHeight(of textView: UITextView) throws -> CGFloat {
        try #require(textView.font).lineHeight
    }

    @Test
    func removesInsetsAndPadding() {
        let textView = makeTextView(text: longText)
        textView.wrapToContent()
        #expect(!textView.isScrollEnabled)
        #expect(textView.contentInset == .zero)
        #expect(textView.verticalScrollIndicatorInsets == .zero)
        #expect(textView.horizontalScrollIndicatorInsets == .zero)
        #expect(textView.contentOffset == .zero)
        #expect(textView.textContainerInset == .zero)
        #expect(textView.textContainer.lineFragmentPadding == 0)
    }

    @Test
    func growsToFitAllLinesAtCurrentWidth() throws {
        let textView = makeTextView(text: longText)
        textView.wrapToContent()
        #expect(textView.bounds.width <= 100)
        #expect(textView.bounds.width > 50)
        #expect(textView.bounds.height > 5 * (try lineHeight(of: textView)))
    }

    @Test
    func shrinksToOneLineOfShortText() throws {
        let textView = makeTextView(text: "Hi")
        textView.wrapToContent()
        #expect(textView.bounds.width < 100)
        #expect(textView.bounds.width > 0)
        #expect(abs(textView.bounds.height - (try lineHeight(of: textView))) < 1)
    }

    @Test
    func keepsOneLineHeightForEmptyText() throws {
        let textView = makeTextView(text: "")
        textView.wrapToContent()
        #expect(textView.bounds.width == 0)
        #expect(abs(textView.bounds.height - (try lineHeight(of: textView))) < 1)
    }

    @Test
    func widerTextViewNeedsFewerLines() {
        let narrow = makeTextView(text: longText)
        let wide = makeTextView(text: longText)
        wide.frame.size.width = 300
        narrow.wrapToContent()
        wide.wrapToContent()
        #expect(wide.bounds.height < narrow.bounds.height)
    }

    @Test
    func fitsItsContentSize() {
        let textView = makeTextView(text: longText)
        textView.wrapToContent()
        textView.layoutIfNeeded()
        #expect(abs(textView.contentSize.height - textView.bounds.height) < 1)
    }

    @Test(arguments: ["👨‍👩‍👧‍👦🇸🇾 e\u{301}", "مرحبا بالعالم، هذا نص طويل يلتف على عدة أسطر"])
    func wrapsUnicodeText(_ text: String) throws {
        let textView = makeTextView(text: text)
        textView.wrapToContent()
        #expect(textView.bounds.width <= 100)
        #expect(textView.bounds.height >= (try lineHeight(of: textView)) - 1)
    }
}
#endif
