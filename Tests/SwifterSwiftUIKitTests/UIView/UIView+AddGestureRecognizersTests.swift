// UIView+AddGestureRecognizersTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAddGestureRecognizersTests {
    @Test
    func addsRecognizersInOrder() {
        let view = UIView()
        let recognizers = [UITapGestureRecognizer(), UIPanGestureRecognizer(), UISwipeGestureRecognizer()]
        view.addGestureRecognizers(recognizers)
        #expect(view.gestureRecognizers == recognizers)
        #expect(recognizers.allSatisfy { $0.view === view })
    }

    @Test
    func appendsAfterExistingRecognizers() {
        let view = UIView()
        let existing = UILongPressGestureRecognizer()
        view.addGestureRecognizer(existing)
        let recognizers = [UITapGestureRecognizer(), UIPanGestureRecognizer()]
        view.addGestureRecognizers(recognizers)
        #expect(view.gestureRecognizers == [existing] + recognizers)
    }

    @Test
    func doesNothingForEmptyArray() {
        let view = UIView()
        view.addGestureRecognizers([])
        #expect(view.gestureRecognizers?.isEmpty ?? true)
    }

    @Test
    func movesRecognizerFromAnotherView() {
        let oldView = UIView()
        let newView = UIView()
        let tap = UITapGestureRecognizer()
        oldView.addGestureRecognizer(tap)
        newView.addGestureRecognizers([tap])
        #expect(tap.view === newView)
        #expect(oldView.gestureRecognizers?.isEmpty ?? true)
        #expect(newView.gestureRecognizers == [tap])
    }
}
#endif
