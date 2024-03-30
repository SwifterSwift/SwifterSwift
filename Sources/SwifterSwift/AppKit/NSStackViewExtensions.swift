// NSStackViewExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

// MARK: - Methods

public extension NSStackView {
    /// SwifterSwift: Add array of arranged subviews to stack view.
    ///
    /// - Parameter subviews: array of arranged subviews to add to self.
    func addArrangedSubviews(_ subviews: [NSView]) {
        subviews.forEach { addArrangedSubview($0) }
    }

    /// SwifterSwift: Remove all arranged subviews in stack view.
    func removeASubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

#endif
