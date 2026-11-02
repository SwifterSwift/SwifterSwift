// UIScrollView+ScrollRightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollRightTests {
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

    func makeScrollView() -> BarInsetScrollView {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        return scrollView
    }

    @Test
    func scrollsRightOnePageAndStopsAtRightEdge() {
        let scrollView = makeScrollView()
        scrollView.contentOffset = CGPoint(x: 250, y: 50)
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 350, y: 50))
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 440, y: 50))
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 440, y: 50))
    }

    @Test
    func stopsAtRightEdgeOfAdjustedInsets() {
        let scrollView = makeScrollView()
        scrollView.barInsets.right = 44
        scrollView.contentOffset = CGPoint(x: 400, y: 0)
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 484, y: 0))
    }

    @Test
    func staysAtLeftEdgeWhenContentIsNarrowerThanBounds() {
        let scrollView = makeScrollView()
        scrollView.contentSize = CGSize(width: 40, height: 100)
        scrollView.contentOffset = CGPoint(x: -20, y: 0)
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -20, y: 0))
    }

    @Test
    func doesNothingForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    #if !os(tvOS)
    @Test
    func snapsToPageWhenPagingIsEnabled() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 250, y: 50)
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 280, y: 50))
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 380, y: 50))
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 440, y: 50))
    }

    @Test
    func treatsOffsetWithinAPointOfBoundaryAsOnIt() {
        // Pages are 1000.1 points wide, so the boundary of page 3 is at 3000.3, which UIKit can't store exactly.
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 1_000.1, height: 100))
        scrollView.contentSize = CGSize(width: 10_000, height: 100)
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 3_000, y: 0)
        scrollView.scrollRight(animated: false)
        #expect(abs(scrollView.contentOffset.x - 4_000.4) <= 0.5)
    }

    @Test
    func doesNothingForEmptyPagingScrollView() {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.scrollRight(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }
    #endif
}
#endif
