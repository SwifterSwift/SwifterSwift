// NSWindowExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension NSWindow {
    
    /// SwifterSwift: Whether to hide the close button
    ///
    /// - Parameters:
    ///     - isHidden: whether to hide.
    func hideCloseButton(_ isHidden: Bool) {
        standardWindowButton(.closeButton)?.isHidden = isHidden
    }
    
    /// SwifterSwift: Whether to hide the Miniaturize button
    ///
    /// - Parameters:
    ///     - isHidden: whether to hide.
    func hideMiniaturizeButton(_ isHidden: Bool) {
        standardWindowButton(.miniaturizeButton)?.isHidden = isHidden
    }
    
    /// SwifterSwift: Whether to hide the Zoom button
    ///
    /// - Parameters:
    ///     - isHidden: whether to hide.
    func hideZoomButton(_ isHidden: Bool) {
        standardWindowButton(.zoomButton)?.isHidden = isHidden
    }
    
    /// SwifterSwift: Whether to hide all buttons
    ///
    /// - Parameters:
    ///     - isHidden: whether to hide.
    func hideAllButton(_ isHidden: Bool) {
        standardWindowButton(.zoomButton)?.isHidden = isHidden
        standardWindowButton(.closeButton)?.isHidden = isHidden
        standardWindowButton(.miniaturizeButton)?.isHidden = isHidden
    }
    
    /// SwifterSwift: Whether to move the window by pressing the background
    ///
    /// - Parameters:
    ///     - movable: Whether to move
    func canMovable(_ movable: Bool) {
        isMovable = movable
        isMovableByWindowBackground = movable
    }
}

#endif
