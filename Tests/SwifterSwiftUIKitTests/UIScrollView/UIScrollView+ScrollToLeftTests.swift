// UIScrollView+ScrollToLeftTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIScrollViewScrollToLeftTests {
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
    func scrollsToLeftOfContentInset() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        scrollView.contentOffset = CGPoint(x: 250, y: 50)
        scrollView.scrollToLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -20, y: 50))
    }

    @Test
    func includesAdjustedInsetsSuchAsSafeArea() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 500)
        scrollView.contentInset.left = 20
        scrollView.barInsets.left = 44
        scrollView.contentOffset = CGPoint(x: 250, y: 0)
        scrollView.scrollToLeft(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: -64, y: 0))
    }

    @Test
    func scrollsToZeroWithoutInsets() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.contentSize = CGSize(width: 500, height: 100)
        scrollView.contentOffset = CGPoint(x: 400, y: 0)
        scrollView.scrollToLeft(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    @Test
    func worksForEmptyScrollView() {
        let scrollView = UIScrollView()
        scrollView.scrollToLeft(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }

    @Test
    func usesPhysicalLeftInRightToLeftLayouts() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.semanticContentAttribute = .forceRightToLeft
        scrollView.contentSize = CGSize(width: 500, height: 100)
        scrollView.contentOffset = CGPoint(x: 400, y: 0)
        scrollView.scrollToLeft(animated: false)
        #expect(scrollView.contentOffset == .zero)
    }
}
#endif
