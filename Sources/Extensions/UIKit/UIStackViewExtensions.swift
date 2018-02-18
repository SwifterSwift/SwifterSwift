//
//  UIStackViewExtensions.swift
//  SwifterSwift-iOS
//
//  Created by Benjamin Meyer on 2/18/18.
//

#if os(iOS) || os(tvOS)
import UIKit
    
// MARK: - Initializers
@available(iOS 9.0, *)
public extension UIStackView {
    /// SwifterSwift: Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///        let stackView = UIStackView(views: [UIView(), UIView()], orientation: .vertical)
    ///
    /// - Parameter views: The UIViews to add to the stack.
    /// - Parameter orientation: The axis along which the arranged views are laid out.(default: .horizontal)
    /// - Parameter spacing: The distance in points between the adjacent edges of the stack view’s arranged views.(default: 0.0)
    /// - Parameter alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis. (default: .fill)
    /// - Parameter distribution: The distribution of the arranged views along the stack view’s axis.(default: .fill)
    /// - Returns: A UIStackView of all views of the given array with the passed configuration.
    public convenience init(views: [UIView], orientation: UILayoutConstraintAxis = .horizontal, spacing: CGFloat = 0.0, alignment: UIStackViewAlignment = .fill, distribution: UIStackViewDistribution = .fill) {
        self.init(arrangedSubviews: views)
        self.axis = orientation
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
#endif
