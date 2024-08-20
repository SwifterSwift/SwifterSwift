// UIColorExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(UIKit)
import UIKit

/// SwifterSwift: Is an enumeration that represents potential errors related to converting hexadecimal strings to colors.
///
/// This enumeration is used to capture and report errors that may occur when attempting to initialize a color using a hexadecimal string.
/// It handles cases where the provided string either does not have the correct length or contains invalid characters.
///
/// - Case `invalidHexLength`: Indicates that the provided hexadecimal string does not have exactly 6 characters,
///   which is required for a valid conversion.
/// - Case `invalidHexFormat`: Indicates that the provided hexadecimal string contains characters that are not valid
///   hexadecimal digits (0-9, A-F).
enum ColorError: Error {

    /// Error that occurs when the length of the hexadecimal string is invalid.
    ///
    /// To convert a hexadecimal string to a color, the string must be exactly 6 characters long
    /// (excluding the optional `#` character). This error is thrown if the string is too short or too long.
    case invalidHexLength

    /// Error that occurs when the hexadecimal string contains invalid characters.
    ///
    /// A valid hexadecimal string should only contain characters from 0-9 and A-F (case insensitive).
    /// This error is thrown if any character in the string is outside of this valid range.
    case invalidHexFormat
}

public extension UIColor {
    #if !os(watchOS)
    /// SwifterSwift: Create a UIColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    #endif

    /// SwifterSwift: Initializes and returns a color object using the specified hexadecimal string.
    ///
    /// This initializer allows you to create a `UIColor` instance from a hexadecimal string representation
    /// of a color. The string can optionally start with a `#`, and it must contain exactly 6 characters
    /// corresponding to the red, green, and blue components of the color.
    ///
    /// - Parameter hex: A string in the format `"#RRGGBB"` or `"RRGGBB"`.
    ///
    /// Example:
    /// ```
    /// let color = UIColor(hex: "#ff0000")
    /// // Creates a red color
    /// ```
    ///
    /// If the input string does not contain exactly 6 characters, the initializer will trigger a runtime
    /// error with a precondition failure.
    ///
    /// - Note: The alpha component is set to 1.0 (fully opaque) by default.
    convenience init(hex: String) throws {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            throw ColorError.invalidHexLength
        }

        let validHexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
        if cString.rangeOfCharacter(from: validHexCharacters.inverted) != nil {
            throw ColorError.invalidHexFormat
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(
            red: round(red * 1000) / 1000,
            green: round(green * 1000) / 1000,
            blue: round(blue * 1000) / 1000,
            alpha: 1.0
        )
    }
}

#endif
