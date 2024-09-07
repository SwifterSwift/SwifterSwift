// NSViewExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

// MARK: - Properties

public extension NSView {

    /// SwifterSwift: Border color of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.borderColor = NSColor.red
    ///    ```
    ///
    /// - Returns: The border color of the view as `NSColor`.
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

    /// SwifterSwift: Border width of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.borderWidth = 2.0
    ///    ```
    ///
    /// - Returns: The border width of the view as `CGFloat`.
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

    /// SwifterSwift: Corner radius of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.cornerRadius = 10
    ///    ```
    ///
    /// - Returns: The corner radius of the view as `CGFloat`.
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

    /// SwifterSwift: Height of the view.
    ///
    ///    ```swift
    ///    view.height = 100
    ///    ```
    ///
    /// - Returns: The height of the view as `CGFloat`.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    /// SwifterSwift: Shadow color of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.shadowColor = NSColor.black
    ///    ```
    ///
    /// - Returns: The shadow color of the view as `NSColor?`.
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

    /// SwifterSwift: Shadow offset of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.shadowOffset = CGSize(width: 5, height: 5)
    ///    ```
    ///
    /// - Returns: The shadow offset of the view as `CGSize`.
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

    /// SwifterSwift: Shadow opacity of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.shadowOpacity = 0.8
    ///    ```
    ///
    /// - Returns: The shadow opacity of the view as `Float`.
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

    /// SwifterSwift: Shadow radius of the view; also inspectable from Storyboard.
    ///
    ///    ```swift
    ///    view.shadowRadius = 5
    ///    ```
    ///
    /// - Returns: The shadow radius of the view as `CGFloat`.
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
    ///
    ///    ```swift
    ///    view.backgroundColor = NSColor.blue
    ///    ```
    ///
    /// - Returns: The background color of the view as `NSColor?`.
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

    /// SwifterSwift: Size of the view.
    ///
    ///    ```swift
    ///    view.size = CGSize(width: 200, height: 100)
    ///    ```
    ///
    /// - Returns: The size of the view as `CGSize`.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    /// SwifterSwift: Width of the view.
    ///
    ///    ```swift
    ///    view.width = 200
    ///    ```
    ///
    /// - Returns: The width of the view as `CGFloat`.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
}

// MARK: - Methods

public extension NSView {

    /// SwifterSwift: Add an array of subviews to the view.
    ///
    ///    ```swift
    ///    view.addSubviews([subview1, subview2])
    ///    ```
    ///
    /// - Parameter subviews: An array of `NSView` objects to add as subviews.
    func addSubviews(_ subviews: [NSView]) {
        subviews.forEach { addSubview($0) }
    }

    /// SwifterSwift: Remove all subviews from the view.
    ///
    ///    ```swift
    ///    view.removeSubviews()
    ///    ```
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}


#endif
