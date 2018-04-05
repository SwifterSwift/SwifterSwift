//
//  UITextFieldExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Enums
public extension UITextField {

	/// SwifterSwift: UITextField text type.
	///
	/// - emailAddress: UITextField is used to enter email addresses.
	/// - password: UITextField is used to enter passwords.
	/// - generic: UITextField is used to enter generic text.
	public enum TextType {
		case emailAddress
		case password
		case generic
	}

}

// MARK: - Properties
public extension UITextField {

	/// SwifterSwift: Set textField for common text types.
	public var textType: TextType {
		get {
			if keyboardType == .emailAddress {
				return .emailAddress
			} else if isSecureTextEntry {
				return .password
			}
			return .generic
		}
		set {
			switch newValue {
			case .emailAddress:
				keyboardType = .emailAddress
				autocorrectionType = .no
				autocapitalizationType = .none
				isSecureTextEntry = false
				placeholder = "Email Address"

			case .password:
				keyboardType = .asciiCapable
				autocorrectionType = .no
				autocapitalizationType = .none
				isSecureTextEntry = true
				placeholder = "Password"

			case .generic:
				isSecureTextEntry = false
			}
		}
	}

	/// SwifterSwift: Check if text field is empty.
	public var isEmpty: Bool {
		return text?.isEmpty == true
	}

	/// SwifterSwift: Return text with no spaces or new lines in beginning and end.
	public var trimmedText: String? {
		return text?.trimmingCharacters(in: .whitespacesAndNewlines)
	}

	/// SwifterSwift: Check if textFields text is a valid email format.
	///
	///		textField.text = "john@doe.com"
	///		textField.hasValidEmail -> true
	///
	///		textField.text = "swifterswift"
	///		textField.hasValidEmail -> false
	///
	public var hasValidEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
						   options: String.CompareOptions.regularExpression,
						   range: nil, locale: nil) != nil
	}

	/// SwifterSwift: Left view tint color.
	@IBInspectable public var leftViewTintColor: UIColor? {
		get {
			guard let iconView = leftView as? UIImageView else { return nil }
			return iconView.tintColor
		}
		set {
			guard let iconView = leftView as? UIImageView else { return }
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}

	/// SwifterSwift: Right view tint color.
	@IBInspectable public var rightViewTintColor: UIColor? {
		get {
			guard let iconView = rightView as? UIImageView else { return nil }
			return iconView.tintColor
		}
		set {
			guard let iconView = rightView as? UIImageView else { return }
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}

}

// MARK: - Methods
public extension UITextField {

	/// SwifterSwift: Clear text.
	public func clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}

	/// SwifterSwift: Set placeholder text color.
	///
	/// - Parameter color: placeholder text color.
	public func setPlaceHolderTextColor(_ color: UIColor) {
		guard let holder = placeholder, !holder.isEmpty else { return }
		self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
	}

	/// SwifterSwift: Add padding to the left of the textfield rect.
	///
	/// - Parameter padding: amount of padding to apply to the left of the textfield rect.
	public func addPaddingLeft(_ padding: CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
		leftView = paddingView
		leftViewMode = .always
	}

	/// SwifterSwift: Add padding to the left of the textfield rect.
	///
	/// - Parameters:
	///   - image: left image
	///   - padding: amount of padding between icon and the left of textfield
	public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
		let imageView = UIImageView(image: image)
		imageView.contentMode = .center
		self.leftView = imageView
		self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
		self.leftViewMode = UITextFieldViewMode.always
	}

}

#endif

#endif
