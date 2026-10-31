// UIScrollView+ScrollDownTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollDownTests {
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
    func scrollsDownOnePageAndStopsAtBottom() {
        let scrollView = makeScrollView()
        scrollView.contentOffset = CGPoint(x: 50, y: 250)
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 350))
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 430))
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 430))
    }

    @Test
    func stopsAtBottomOfAdjustedInsets() {
        let scrollView = makeScrollView()
        scrollView.barInsets.bottom = 34
        scrollView.contentOffset = CGPoint(x: 0, y: 400)
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: 464))
    }

    @Test
    func staysAtTopWhenContentIsShorterThanBounds() {
        let scrollView = makeScrollView()
        scrollView.contentSize = CGSize(width: 100, height: 40)
        scrollView.contentOffset = CGPoint(x: 0, y: -10)
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -10))
    }

    @Test
    func doesNothingForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    #if !os(tvOS)
    @Test
    func scrollsToNextPageBoundaryAndReachesEndWhenPagingIsEnabled() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 50, y: 250)
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 290))
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 390))
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 430))
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 50, y: 430))
    }

    @Test
    func measuresPagesFromTopOfAdjustedInsets() {
        let scrollView = makeScrollView()
        scrollView.isPagingEnabled = true
        scrollView.barInsets.top = 90
        scrollView.contentOffset = CGPoint(x: 0, y: -100)
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: 0))
    }

    @Test
    func treatsOffsetWithinAPointOfBoundaryAsOnIt() {
        // Pages are 1000.1 points high, so the boundary of page 3 is at 3000.3, which UIKit can't store exactly.
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 1_000.1))
        scrollView.contentSize = CGSize(width: 100, height: 10_000)
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint(x: 0, y: 3_000)
        scrollView.scrollDown(animated: false)
        #expect(abs(scrollView.contentOffset.y - 4_000.4) <= 0.5)
    }

    @Test
    func doesNothingForEmptyPagingScrollView() {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.scrollDown(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }
    #endif
}
#endif
