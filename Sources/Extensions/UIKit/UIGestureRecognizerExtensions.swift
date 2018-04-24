//
//  UIGestureRecognizerExtensions.swift
//  SwifterSwift
//
//  Created by Morgan Dock on 4/21/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UIGestureRecognizer {

    /// SwifterSwift: Remove Gesture Recognizer from its view.
    public func removeFromView() {
        self.view?.removeGestureRecognizer(self)
    }
}
#endif

#endif
