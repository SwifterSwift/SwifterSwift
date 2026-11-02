// UIScrollView+ScrollToRightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollToRightTests {
    /// A scroll view under bars: its adjusted content inset adds `barInsets` to its content inset.
    final class BarInsetScrollView: UIScrollView {
        var barInsets = UIEdgeInsets.zero

        override var adjustedContentInset: UIEdgeInsets {
            UIEdgeInsets(
                top: contentInset.top + barInsets.top,
                left: contentInset.left + barInsets.left,
                bottom: contentInset.bottom + barInsets.bottom,
                right: contentInset.right + barInsets.right
            )
        }
    }

    @Test
    func scrollsToRightOfContentInset() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        scrollView.contentOffset = CGPoint(x: 50, y: 50)
        scrollView.scrollToRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 440, y: 50))
    }

    @Test
    func includesAdjustedInsetsSuchAsSafeArea() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 100)
        scrollView.contentInset.right = 40
        scrollView.barInsets.right = 44
        scrollView.scrollToRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 484, y: 0))
    }

    @Test
    func scrollsPartlyIntoLeftInsetWhenNarrowContentAndInsetsOverflow() {
        // 30 points of left insets, 40 of content and 40 of right inset overflow the 100-point scroll view by 10.
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 40, height: 100)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
        scrollView.barInsets.left = 10
        scrollView.scrollToRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -20, y: 0))
    }

    @Test
    func staysAtLeftWhenContentAndInsetsAreNarrowerThanBounds() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 10, height: 100)
        scrollView.contentInset.left = 10
        scrollView.barInsets.left = 20
        scrollView.scrollToRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -30, y: 0))
    }

    @Test
    func worksForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollToRight(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    @Test
    func usesPhysicalRightInRightToLeftLayouts() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.semanticContentAttribute = .forceRightToLeft
        scrollView.contentSize = CGSize(width: 500, height: 100)
        scrollView.scrollToRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 400, y: 0))
    }
}
#endif
