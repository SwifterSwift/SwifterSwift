// UIViewDeprecated.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UIView {
    
    /// SwifterSwift: Remove all subviews in view.
    @available(*, deprecated, renamed: "removeAllSubviews", message: "Use removeAllSubviews")
    func removeSubviews() {
        removeAllSubviews()
    }
}

#endif
