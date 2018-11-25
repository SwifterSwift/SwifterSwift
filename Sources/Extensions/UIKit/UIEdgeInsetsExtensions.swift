//
//  UIEdgeInsetsExtensions.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 15/06/18.
//  Copyright © 2018 SwifterSwift
//
#if canImport(UIKit)
import UIKit

// MARK: - Properties
extension UIEdgeInsets {
    /// SwifterSwift: Return the vertical insets. The vertical insets is composed by top + bottom.
    ///
    public var vertical: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/Extensions/UIEdgeInsets%2BExtensions.swift
        return top + bottom
    }

    /// SwifterSwift: Return the horizontal insets. The horizontal insets is composed by  left + right.
    ///
    public var horizontal: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/Extensions/UIEdgeInsets%2BExtensions.swift
        return left + right
    }

}

// MARK: - Methods
extension UIEdgeInsets {
    /// SwifterSwift: Creates an `UIEdgeInsets` with the inset value applied to all (top, bottom, right, left)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    public init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` with the horizontal value equally divided and applied to right and left.
    ///               And the vertical value equally divided and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to right and left.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical/2, left: horizontal/2, bottom: vertical/2, right: horizontal/2)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(top: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.top + top, left: left, bottom: bottom, right: right)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` based on current value and left offset.
    ///
    /// - Parameters:
    ///   - left: Offset to be applied in to the left edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(left: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: self.left + left, bottom: bottom, right: right)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(bottom: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: self.bottom + bottom, right: right)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` based on current value and right offset.
    ///
    /// - Parameters:
    ///   - right: Offset to be applied in to the right edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(right: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: self.right + right)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(horizontal: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left + horizontal/2, bottom: bottom, right: right + horizontal/2)
    }

    /// SwifterSwift: Creates an `UIEdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(vertical: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top + vertical/2, left: left, bottom: bottom + vertical/2, right: right)
    }
}

// MARK: - Operators
extension UIEdgeInsets {

    /// SwifterSwift: Add all the properties of two `UIEdgeInsets` to create their addition.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression
    ///   - rhs: The right-hand expression
    /// - Returns: A new `UIEdgeInsets` instance where the values of `lhs` and `rhs` are added together.
    public static func + (_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top + rhs.top,
                            left: lhs.left + rhs.left,
                            bottom: lhs.bottom + rhs.bottom,
                            right: lhs.right + rhs.right)
    }

    /// SwifterSwift: Add all the properties of two `UIEdgeInsets` to the left-hand instance.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression to be mutated
    ///   - rhs: The right-hand expression
    public static func += (_ lhs: inout UIEdgeInsets, _ rhs: UIEdgeInsets) {
        lhs.top += rhs.top
        lhs.left += rhs.left
        lhs.bottom += rhs.bottom
        lhs.right += rhs.right
    }

}

#endif
