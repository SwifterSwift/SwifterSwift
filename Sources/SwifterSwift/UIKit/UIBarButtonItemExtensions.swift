// UIBarButtonItemExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties

public extension UIBarButtonItem {
    /// SwifterSwift: Creates a flexible space UIBarButtonItem.
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}

// MARK: - Methods

public extension UIBarButtonItem {
    /// SwifterSwift: Add Target to UIBarButtonItem.
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }

    /// SwifterSwift: Creates a fixed space UIBarButtonItem with a specific width.
    ///
    /// - Parameter width: Width of the UIBarButtonItem.
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
}

#endif
