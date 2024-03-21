// UIStackViewExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Initializers

public extension UIStackView {
    private class BackgroundView: UIView {}

    /// SwifterSwift: Add background color to UIStackView
    var backgroundViewColor: UIColor? {
        get {
            if #available(iOS 14.0, *) {
                return backgroundColor
            } else {
                return subviews.first(where: { $0 is BackgroundView })?.backgroundColor
            }
        }
        set {
            if #available(iOS 14.0, *) {
                backgroundColor = newValue
            } else {
                if let existingBackgroundView = subviews.first(where: { $0 is BackgroundView }) {
                    existingBackgroundView.backgroundColor = newValue
                } else {
                    let backgroundView = BackgroundView()
                    backgroundView.backgroundColor = newValue
                    insertSubview(backgroundView, at: 0)
                    backgroundView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        backgroundView.topAnchor.constraint(equalTo: topAnchor),
                        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
                    ])
                }
            }
        }
    }

    /// SwifterSwift: Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views (default:
    /// 0.0).
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis (default: .fill).
    ///   - distribution: The distribution of the arranged views along the stack view’s axis (default: .fill).
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }

    /// SwifterSwift: Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    /// SwifterSwift: Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }

    /// SwifterSwift: Exchanges two views of the arranged subviews.
    /// - Parameters:
    ///   - view1: first view to swap.
    ///   - view2: second view to swap.
    ///   - animated: set true to animate swap (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - delay: animation delay in seconds (default is 1 second).
    ///   - options: animation options (default is AnimationOptions.curveLinear).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func swap(_ view1: UIView, _ view2: UIView,
              animated: Bool = false,
              duration: TimeInterval = 0.25,
              delay: TimeInterval = 0,
              options: UIView.AnimationOptions = .curveLinear,
              completion: ((Bool) -> Void)? = nil) {
        func swapViews(_ view1: UIView, _ view2: UIView) {
            guard let view1Index = arrangedSubviews.firstIndex(of: view1),
                  let view2Index = arrangedSubviews.firstIndex(of: view2) else { return }
            removeArrangedSubview(view1)
            insertArrangedSubview(view1, at: view2Index)

            removeArrangedSubview(view2)
            insertArrangedSubview(view2, at: view1Index)
        }
        if animated {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                swapViews(view1, view2)
                self.layoutIfNeeded()
            }, completion: completion)
        } else {
            swapViews(view1, view2)
        }
    }
}

#endif
