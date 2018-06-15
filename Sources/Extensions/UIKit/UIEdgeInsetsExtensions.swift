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
}

#endif
