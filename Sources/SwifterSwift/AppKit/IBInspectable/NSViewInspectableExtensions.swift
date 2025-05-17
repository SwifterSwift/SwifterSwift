// NSViewInspectableExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSView {
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable
    var borderColor: NSColor? {
        get {
            guard let color = layer?.borderColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.borderColor = newValue?.cgColor
        }
    }

    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer?.borderWidth ?? 0
        }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }

    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer?.cornerRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.masksToBounds = true
            layer?.cornerRadius = newValue.magnitude
        }
    }

    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowColor: NSColor? {
        get {
            guard let color = layer?.shadowColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.shadowColor = newValue?.cgColor
        }
    }

    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer?.shadowOffset ?? CGSize.zero
        }
        set {
            wantsLayer = true
            layer?.shadowOffset = newValue
        }
    }

    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer?.shadowOpacity ?? 0
        }
        set {
            wantsLayer = true
            layer?.shadowOpacity = newValue
        }
    }

    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer?.shadowRadius ?? 0
        }
        set {
            wantsLayer = true
            layer?.shadowRadius = newValue
        }
    }

    /// SwifterSwift: Background color of the view; also inspectable from Storyboard.
    @IBInspectable
    var backgroundColor: NSColor? {
        get {
            if let colorRef = layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}

#endif
