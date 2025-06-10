// UIButtonExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties

public extension UIButton {
    /// SwifterSwift: Attributed title of disabled state for button.
    var attributedTitleForDisabled: NSAttributedString? {
        get { attributedTitle(for: .disabled) }
        set { setAttributedTitle(newValue, for: .disabled) }
    }

    /// SwifterSwift: Attributed title of highlighted state for button.
    var attributedTitleForHighlighted: NSAttributedString? {
        get { attributedTitle(for: .highlighted) }
        set { setAttributedTitle(newValue, for: .highlighted) }
    }

    /// SwifterSwift: Attributed title of normal state for button.
    var attributedTitleForNormal: NSAttributedString? {
        get { attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }

    /// SwifterSwift: Attributed title of selected state for button.
    var attributedTitleForSelected: NSAttributedString? {
        get { attributedTitle(for: .selected) }
        set { setAttributedTitle(newValue, for: .selected) }
    }

    /// SwifterSwift: Attributed title of focused state for button.
    var attributedTitleForFocused: NSAttributedString? {
        get { attributedTitle(for: .focused) }
        set { setAttributedTitle(newValue, for: .focused) }
    }
}

// MARK: - Methods

public extension UIButton {
    private var states: [UIControl.State] {
        [.normal, .selected, .highlighted, .disabled, .focused]
    }

    /// SwifterSwift: Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }

    /// SwifterSwift: Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { setTitleColor(color, for: $0) }
    }

    /// SwifterSwift: Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { setTitle(title, for: $0) }
    }

    /// SwifterSwift: Set attributed title for all states.
    ///
    /// - Parameter title: title string.
    func setAttributedTitleForAllStates(_ title: NSAttributedString) {
        states.forEach { setAttributedTitle(title, for: $0) }
    }

    /// SwifterSwift: Center align title text and image.
    /// - Parameters:
    ///   - imageAboveText: set true to make image above title text, default is false, image on left of text.
    ///   - spacing: spacing between title text and image.
    func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
        if imageAboveText {
            // https://stackoverflow.com/questions/2451223/#7199529
            guard
                let imageSize = imageView?.image?.size,
                let text = titleLabel?.text,
                let font = titleLabel?.font else { return }

            let titleSize = text.size(withAttributes: [.font: font])

            let titleOffset = -(imageSize.height + spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

            let imageOffset = -(titleSize.height + spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }

    /// SwifterSwift: Set background color for specified state.
    /// - Parameters:
    ///   - color: The color of the image that will be set as background for the button in the given state.
    ///   - forState: set the UIControl.State for the desired color.
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        clipsToBounds = true // maintain corner radius

        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { context in
            color.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            draw(.zero)
        }
        setBackgroundImage(colorImage, for: forState)
    }
}

#endif
