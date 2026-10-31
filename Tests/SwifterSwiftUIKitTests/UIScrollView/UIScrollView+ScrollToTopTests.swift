// UIScrollView+ScrollToTopTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollToTopTests {
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
    func scrollsToTopOfContentInset() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        scrollView.contentOffset = CGPoint(x: 50, y: 250)
        scrollView.scrollToTop(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: -10))
    }

    @Test
    func includesAdjustedInsetsSuchAsBars() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset.top = 10
        scrollView.barInsets.top = 100
        scrollView.contentOffset = CGPoint(x: 0, y: 250)
        scrollView.scrollToTop(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -110))
    }

    @Test
    func scrollsToZeroWithoutInsets() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 100, height: 500)
        scrollView.contentOffset = CGPoint(x: 0, y: 400)
        scrollView.scrollToTop(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    @Test
    func worksForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollToTop(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    @Test
    func movesBackFromOverscrollAboveTheTop() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 100, height: 500)
        scrollView.contentInset.top = 20
        scrollView.contentOffset = CGPoint(x: 0, y: -80)
        scrollView.scrollToTop(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -20))
    }
}
#endif
