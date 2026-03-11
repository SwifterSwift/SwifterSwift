// UIGestureRecognizerExtensions.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UIGestureRecognizer {
    /// SwifterSwift: Remove Gesture Recognizer from its view.
    func removeFromView() {
        view?.removeGestureRecognizer(self)
    }
}

#endif
