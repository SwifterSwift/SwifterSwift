// UILabel+RequiredHeightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UILabelRequiredHeightTests {
    let longText = "A long text that needs several lines to show completely in a narrow label."

    func makeLabel(text: String?, width: CGFloat = 100, numberOfLines: Int = 0) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 10))
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = numberOfLines
        label.text = text
        return label
    }

    @Test
    func measuresOneLineOfShortText() throws {
        let label = makeLabel(text: "Hi")
        let font = try #require(label.font)
        #expect(abs(label.requiredHeight - font.lineHeight) < 1)
    }

    @Test
    func measuresAllLinesWhenUnlimited() {
        let oneLine = makeLabel(text: "Hi").requiredHeight
        let label = makeLabel(text: longText)
        #expect(label.requiredHeight > 3 * oneLine)
    }

    @Test
    func respectsNumberOfLines() {
        let oneLine = makeLabel(text: "Hi").requiredHeight
        #expect(makeLabel(text: longText, numberOfLines: 1).requiredHeight == oneLine)
        let twoLines = makeLabel(text: longText, numberOfLines: 2).requiredHeight
        #expect(twoLines > oneLine)
        #expect(twoLines < makeLabel(text: longText).requiredHeight)
    }

    @Test
    func widerLabelNeedsLessHeight() {
        let narrow = makeLabel(text: longText, width: 100)
        let wide = makeLabel(text: longText, width: 400)
        #expect(wide.requiredHeight < narrow.requiredHeight)
    }

    @Test
    func usesAttributedText() {
        let label = makeLabel(text: nil)
        label.attributedText = NSAttributedString(string: "Hi", attributes: [.font: UIFont.systemFont(ofSize: 60)])
        #expect(label.requiredHeight > makeLabel(text: "Hi").requiredHeight * 2)
    }

    @Test(arguments: [nil, ""] as [String?])
    func isZeroWithoutText(_ text: String?) {
        #expect(makeLabel(text: text).requiredHeight == 0)
    }

    @Test
    func doesNotWrapAtZeroWidth() {
        let oneLine = makeLabel(text: "Hi").requiredHeight
        #expect(makeLabel(text: longText, width: 0).requiredHeight == oneLine)
    }

    @Test
    func doesNotChangeLabel() {
        let label = makeLabel(text: longText)
        _ = label.requiredHeight
        #expect(label.frame == CGRect(x: 0, y: 0, width: 100, height: 10))
        #expect(label.numberOfLines == 0)
    }

    @Test(arguments: ["👨‍👩‍👧‍👦 🇸🇾 🇯🇵", "e\u{301}e\u{301}e\u{301}", "مرحبا بالعالم، هذا نص طويل يحتاج إلى عدة أسطر"])
    func measuresUnicodeText(_ text: String) {
        let label = makeLabel(text: text)
        #expect(label.requiredHeight > 0)
        #expect(
            label.requiredHeight
                == label.sizeThatFits(CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude)).height)
    }
}
#endif
