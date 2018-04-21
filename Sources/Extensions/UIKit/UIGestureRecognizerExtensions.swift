//
//  UIGestureRecognizerExtensions.swift
//  SwifterSwift
//
//  Created by Morgan Dock on 4/21/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension UIGestureRecognizer {

    /// SwifterSwift: Remove Gesture Recognizer from view.
    public func remove() {
        self.view?.removeGestureRecognizer(self)
        
    }
}
#endif
