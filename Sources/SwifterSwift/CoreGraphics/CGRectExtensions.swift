//
//  CGRectExtensions.swift
//  SwifterSwift
//
//  Created by Chen Qizhi on 2020/03/11.
//  Copyright © 2020 SwifterSwift
//
#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - Properties
public extension CGRect {

    /// SwifterSwift: Return center of rect
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

}

// MARK: - Initializers
public extension CGRect {

    /// SwifterSwift: Create a `CGRect` instance with center and size
    /// - Parameters:
    ///   - center: center of the new rect
    ///   - size: size of the new rect
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }

}

// MARK: - Methods
public extension CGRect {

    /// SwifterSwift: Corners and center of `CGRect`, can be use for resizing,
    enum Anchor {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case center
    }

    /// SwifterSwift: Create a new `CGRect` by resizing with specified anchor
    /// - Parameters:
    ///   - size: new size to be applied
    ///   - anchor: specified anchor, excample:
    ///
    ///          anchor = .bottomLeft:
    ///
    ///                       A2------B2
    ///          A----B       |        |
    ///          |    |  -->  |        |
    ///          C----D       C-------D2
    ///
    func resizing(to size: CGSize, anchor: CGRect.Anchor = .topLeft) -> CGRect {
        var origin = self.origin
        switch anchor {
        case .topRight:
            origin.x = maxX - size.width
        case .bottomLeft:
            origin.y = maxY - size.height
        case .bottomRight:
            origin.x = maxX - size.width
            origin.y = maxY - size.height
        case .center:
            origin.x = midX - size.width / 2.0
            origin.y = midY - size.height / 2.0
        default:
            break
        }

        return CGRect(origin: origin, size: size)
    }

}

#endif
