// UIScrollView+ScrollToBottomTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollToBottomTests {
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
    func scrollsToBottomOfContentInset() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        scrollView.contentOffset = CGPoint(x: 50, y: 50)
        scrollView.scrollToBottom(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 430))
    }

    @Test
    func includesAdjustedInsetsSuchAsHomeIndicator() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 100, height: 500)
        scrollView.contentInset.bottom = 30
        scrollView.barInsets.bottom = 34
        scrollView.scrollToBottom(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: 464))
    }

    @Test
    func scrollsPartlyIntoTopInsetWhenShortContentAndInsetsOverflow() {
        // 60 points of top insets, 40 of content and 30 of bottom inset overflow the 100-point scroll view by 30.
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 100, height: 40)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
        scrollView.barInsets.top = 50
        scrollView.scrollToBottom(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -30))
    }

    @Test
    func staysAtTopWhenContentAndInsetsAreShorterThanBounds() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 100, height: 10)
        scrollView.contentInset.top = 10
        scrollView.barInsets.top = 20
        scrollView.scrollToBottom(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -30))
    }

    @Test
    func scrollsToExactBottomWhenContentJustFits() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 100, height: 100)
        scrollView.scrollToBottom(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    @Test
    func worksForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollToBottom(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }
}
#endif
