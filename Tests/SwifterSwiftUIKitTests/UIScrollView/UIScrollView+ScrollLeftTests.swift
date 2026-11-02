// UIScrollView+ScrollLeftTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollLeftTests {
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
    func scrollsLeftOnePageAndStopsAtLeftEdge() {
        let scrollView = makeScrollView()
        scrollView.contentOffset = CGPoint(x: 250, y: 50)
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 150, y: 50))
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 50))
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -20, y: 50))
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -20, y: 50))
    }

    @Test
    func stopsAtLeftEdgeOfAdjustedInsets() {
        let scrollView = makeScrollView()
        scrollView.barInsets.left = 44
        scrollView.contentOffset = CGPoint(x: 30, y: 0)
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -64, y: 0))
    }

    @Test
    func doesNothingForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    #if !os(tvOS)
    @Test
    func scrollsToPreviousPageBoundaryWhenPagingIsEnabled() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 250, y: 50)
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 180, y: 50))
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 80, y: 50))
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -20, y: 50))
    }

    @Test
    func scrollsFromEndOfContentToLastBoundary() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 440, y: 0)
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 380, y: 0))
    }

    @Test
    func treatsOffsetWithinAPointOfBoundaryAsOnIt() {
        // Pages are 1000.1 points wide, so the boundary of page 3 is at 3000.3, which UIKit can't store exactly.
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 1_000.1, height: 100))
        scrollView.contentSize = CGSize(width: 10_000, height: 100)
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 3_000.5, y: 0)
        scrollView.scrollLeft(animated: false)
        #expect(abs(scrollView.contentOffset.x - 2_000.2) <= 0.5)
    }

    @Test
    func doesNothingForEmptyPagingScrollView() {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.scrollLeft(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }
    #endif
}
#endif
