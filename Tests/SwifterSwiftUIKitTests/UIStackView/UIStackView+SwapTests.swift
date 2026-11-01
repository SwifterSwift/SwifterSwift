// UIStackView+SwapTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIStackViewSwapTests {
    @Test
    func swapsViewsInEitherOrder() {
        let views = (0..<5).map { _ in UIView() }
        let stack = UIStackView(arrangedSubviews: views)
        stack.swap(views[0], views[2])
        #expect(stack.arrangedSubviews == [views[2], views[1], views[0], views[3], views[4]])
        stack.swap(views[4], views[1])
        #expect(stack.arrangedSubviews == [views[2], views[4], views[0], views[3], views[1]])
    }

    @Test
    func swapsAdjacentViews() {
        let first = UIView()
        let second = UIView()
        let stack = UIStackView(arrangedSubviews: [first, second])
        stack.swap(first, second)
        #expect(stack.arrangedSubviews == [second, first])
        #expect(stack.subviews.count == 2)
    }

    @Test
    func doesNothingForSameView() {
        let views = [UIView(), UIView()]
        let stack = UIStackView(arrangedSubviews: views)
        stack.swap(views[0], views[0])
        #expect(stack.arrangedSubviews == views)
    }

    @Test
    func doesNothingWhenViewIsNotArranged() {
        let views = [UIView(), UIView()]
        let stranger = UIView()
        let stack = UIStackView(arrangedSubviews: views)
        var result: Bool?
        stack.swap(views[0], stranger) { result = $0 }
        #expect(stack.arrangedSubviews == views)
        #expect(stranger.superview == nil)
        #expect(result == true)
    }

    @Test
    func callsCompletionImmediatelyWhenNotAnimated() {
        let views = [UIView(), UIView()]
        let stack = UIStackView(arrangedSubviews: views)
        var result: Bool?
        stack.swap(views[0], views[1]) { result = $0 }
        #expect(result == true)
    }

    @Test(.timeLimit(.minutes(5)))
    func swapsAndCallsCompletionWhenAnimated() async {
        let views = [UIView(), UIView(), UIView()]
        let stack = UIStackView(arrangedSubviews: views)
        let finished = await withCheckedContinuation { continuation in
            stack.swap(views[0], views[2], animated: true, duration: 0.05) { continuation.resume(returning: $0) }
            #expect(stack.arrangedSubviews == [views[2], views[1], views[0]])
        }
        #expect(finished)
        #expect(stack.arrangedSubviews == [views[2], views[1], views[0]])
    }
}
#endif
