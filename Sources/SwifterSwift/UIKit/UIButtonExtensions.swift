//
//  UIButtonExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UIButton {

    /// SwifterSwift: Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }

    /// SwifterSwift: Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }

    /// SwifterSwift: Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    /// SwifterSwift: Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    /// SwifterSwift: Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }

    /// SwifterSwift: Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }

    /// SwifterSwift: Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    /// SwifterSwift: Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    /// SwifterSwift: Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }

    /// SwifterSwift: Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }

    /// SwifterSwift: Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    /// SwifterSwift: Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }

}

// MARK: - Methods
public extension UIButton {

    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
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

    /// SwifterSwift: Center align title text and image on UIButton
    ///
    /// - Parameter spacing: spacing between UIButton title text and UIButton Image.
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

}

#endif
