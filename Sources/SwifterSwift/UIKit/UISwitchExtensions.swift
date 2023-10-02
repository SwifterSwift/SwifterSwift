// UISwitchExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Methods

public extension UISwitch {
    /// SwifterSwift: Toggle a UISwitch.
    ///
    /// - Parameter animated: set true to animate the change (default is true).
    func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }
}

#endif
