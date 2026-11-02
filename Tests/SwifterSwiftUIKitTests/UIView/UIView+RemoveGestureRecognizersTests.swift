// UIView+RemoveGestureRecognizersTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewRemoveGestureRecognizersTests {
    @Test
    func removesOnlyTheGivenRecognizers() {
        let view = UIView()
        let tap = UITapGestureRecognizer()
        let pan = UIPanGestureRecognizer()
        let swipe = UISwipeGestureRecognizer()
        view.gestureRecognizers = [tap, pan, swipe]
        view.removeGestureRecognizers([tap, pan])
        #expect(view.gestureRecognizers == [swipe])
        #expect(tap.view == nil)
        #expect(pan.view == nil)
        #expect(swipe.view === view)
    }

    @Test
    func removesAllRecognizers() {
        let view = UIView()
        let recognizers = [UITapGestureRecognizer(), UIPanGestureRecognizer()]
        view.gestureRecognizers = recognizers
        view.removeGestureRecognizers(recognizers)
        #expect(view.gestureRecognizers?.isEmpty ?? true)
    }

    @Test
    func ignoresRecognizerAttachedToAnotherView() {
        let view = UIView()
        let otherView = UIView()
        let tap = UITapGestureRecognizer()
        otherView.addGestureRecognizer(tap)
        view.removeGestureRecognizers([tap])
        #expect(tap.view === otherView)
        #expect(otherView.gestureRecognizers == [tap])
    }

    @Test
    func ignoresRecognizerThatIsNotAttached() {
        let view = UIView()
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        view.removeGestureRecognizers([UIPanGestureRecognizer()])
        #expect(view.gestureRecognizers == [tap])
    }

    @Test
    func doesNothingForEmptyArray() {
        let view = UIView()
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        view.removeGestureRecognizers([])
        #expect(view.gestureRecognizers == [tap])
    }
}
#endif
