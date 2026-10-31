// UIScrollView+ScrollUpTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollUpTests {
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
    func scrollsUpOnePageAndStopsAtTop() {
        let scrollView = makeScrollView()
        scrollView.contentOffset = CGPoint(x: 50, y: 250)
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 150))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 50))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: -10))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: -10))
    }

    @Test
    func stopsAtTopOfAdjustedInsets() {
        let scrollView = makeScrollView()
        scrollView.barInsets.top = 90
        scrollView.contentOffset = CGPoint(x: 0, y: 30)
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -70))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -100))
    }

    @Test
    func doesNothingForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    #if !os(tvOS)
    @Test
    func scrollsToPreviousPageBoundaryWhenPagingIsEnabled() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 50, y: 290)
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 190))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 90))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: -10))
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: -10))
    }

    @Test
    func scrollsFromBetweenBoundariesToBoundaryAbove() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 0, y: 250)
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: 190))
    }

    @Test
    func scrollsFromEndOfContentToLastBoundary() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 0, y: 430)
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: 390))
    }

    @Test
    func measuresPagesFromTopOfAdjustedInsets() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.barInsets.top = 90
        scrollView.contentOffset = CGPoint(x: 0, y: 200)
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: 100))
    }

    @Test
    func treatsOffsetWithinAPointOfBoundaryAsOnIt() {
        // Pages are 1000.1 points high, so the boundary of page 3 is at 3000.3, which UIKit can't store exactly.
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 1_000.1))
        scrollView.contentSize = CGSize(width: 100, height: 10_000)
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 0, y: 3_000.5)
        scrollView.scrollUp(animated: false)
        #expect(abs(scrollView.contentOffset.y - 2_000.2) <= 0.5)
    }

    @Test
    func doesNothingForEmptyPagingScrollView() {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.scrollUp(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }
    #endif
}
#endif
