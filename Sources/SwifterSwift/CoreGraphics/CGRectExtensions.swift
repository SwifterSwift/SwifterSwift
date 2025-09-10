// CGRectExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - Properties

public extension CGRect {
    /// SwifterSwift: Center of the rect.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.center) // (25.0, 30.0)
    ///     rect.center = CGPoint(x: 50, y: 60)
    ///     print(rect) // (35.0, 40.0, 30.0, 40.0)
    ///
    var center: CGPoint {
        get {
            CGPoint(x: midX, y: midY)
        }
        set {
            self = offsetBy(dx: newValue.x - midX, dy: newValue.y - midY)
        }
    }

    /// SwifterSwift: Top left corner of the rect.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.topLeft) // (10.0, 20.0)
    ///     rect.topLeft = CGPoint(x: 50, y: 60)
    ///     print(rect) // (50.0, 60.0, 30.0, 40.0)
    ///
    var topLeft: CGPoint {
        get {
            CGPoint(x: minX, y: minY)
        }
        set {
            self = offsetBy(dx: newValue.x - minX, dy: newValue.y - minY)
        }
    }

    /// SwifterSwift: Center of the top rect edge.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.topCenter) // (25.0, 20.0)
    ///     rect.topCenter = CGPoint(x: 50, y: 60)
    ///     print(rect) // (35.0, 60.0, 30.0, 40.0)
    ///
    var topCenter: CGPoint {
        get {
            CGPoint(x: midX, y: minY)
        }
        set {
            self = offsetBy(dx: newValue.x - midX, dy: newValue.y - minY)
        }
    }

    /// SwifterSwift: Top right corner of the rect.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.topRight) // (40.0, 20.0)
    ///     rect.topRight = CGPoint(x: 50, y: 60)
    ///     print(rect) // (20.0, 60.0, 30.0, 40.0)
    ///
    var topRight: CGPoint {
        get {
            CGPoint(x: maxX, y: minY)
        }
        set {
            self = offsetBy(dx: newValue.x - maxX, dy: newValue.y - minY)
        }
    }

    /// SwifterSwift: Center of the left rect edge.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.centerLeft) // (10.0, 40.0)
    ///     rect.centerLeft = CGPoint(x: 50, y: 60)
    ///     print(rect) // (50.0, 40.0, 30.0, 40.0)
    ///
    var centerLeft: CGPoint {
        get {
            CGPoint(x: minX, y: midY)
        }
        set {
            self = offsetBy(dx: newValue.x - minX, dy: newValue.y - midY)
        }
    }

    /// SwifterSwift: Center of the right rect edge.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.centerRight) // (40.0, 40.0)
    ///     rect.centerRight = CGPoint(x: 50, y: 60)
    ///     print(rect) // (20.0, 40.0, 30.0, 40.0)
    ///
    var centerRight: CGPoint {
        get {
            CGPoint(x: maxX, y: midY)
        }
        set {
            self = offsetBy(dx: newValue.x - maxX, dy: newValue.y - midY)
        }
    }

    /// SwifterSwift: Bottom left corner of the rect.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.bottomLeft) // (10.0, 60.0)
    ///     rect.bottomLeft = CGPoint(x: 50, y: 60)
    ///     print(rect) // (50.0, 20.0, 30.0, 40.0)
    ///
    var bottomLeft: CGPoint {
        get {
            CGPoint(x: minX, y: maxY)
        }
        set {
            self = offsetBy(dx: newValue.x - minX, dy: newValue.y - maxY)
        }
    }

    /// SwifterSwift: Center of the top rect edge.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.bottomCenter) // (25.0, 60.0)
    ///     rect.bottomCenter = CGPoint(x: 50, y: 60)
    ///     print(rect) // (35.0, 20.0, 30.0, 40.0)
    ///
    var bottomCenter: CGPoint {
        get {
            CGPoint(x: midX, y: maxY)
        }
        set {
            self = offsetBy(dx: newValue.x - midX, dy: newValue.y - maxY)
        }
    }

    /// SwifterSwift: Top right corner of the rect.
    ///
    ///     var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    ///     print(rect.bottomRight) // (40.0, 60.0)
    ///     rect.bottomRight = CGPoint(x: 50, y: 60)
    ///     print(rect) // (20.0, 20.0, 30.0, 40.0)
    ///
    var bottomRight: CGPoint {
        get {
            CGPoint(x: maxX, y: maxY)
        }
        set {
            self = offsetBy(dx: newValue.x - maxX, dy: newValue.y - maxY)
        }
    }
}

// MARK: - Initializers

public extension CGRect {
    /// SwifterSwift: Create a `CGRect` instance with center and size.
    /// - Parameters:
    ///   - center: center of the new rect.
    ///   - size: size of the new rect.
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
}

// MARK: - Methods

public extension CGRect {
    /// SwifterSwift: Create a new `CGRect` by resizing with specified anchor.
    /// - Parameters:
    ///   - size: new size to be applied.
    ///   - anchor: specified anchor, a point in normalized coordinates -
    ///     '(0, 0)' is the top left corner of rect，'(1, 1)' is the bottom right corner of rect,
    ///     defaults to '(0.5, 0.5)'. Example:
    ///
    ///          anchor = CGPoint(x: 0.0, y: 1.0):
    ///
    ///                       A2------B2
    ///          A----B       |        |
    ///          |    |  -->  |        |
    ///          C----D       C-------D2
    ///
    func resizing(to size: CGSize, anchor: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> CGRect {
        let sizeDelta = CGSize(width: size.width - width, height: size.height - height)
        return CGRect(origin: CGPoint(x: minX - sizeDelta.width * anchor.x,
                                      y: minY - sizeDelta.height * anchor.y),
                      size: size)
    }
}

#endif
