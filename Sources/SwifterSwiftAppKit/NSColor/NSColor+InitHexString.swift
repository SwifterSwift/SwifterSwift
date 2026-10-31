// NSColor+InitHexString.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Creates an sRGB color from a CSS-style hex string, or returns `nil` if the string is invalid.
    ///
    /// The string has 3, 4, 6 or 8 hexadecimal digits, in either case, optionally preceded by `#`, `0x` or `0X`:
    ///
    /// - `RGB` and `RGBA` are short forms where each digit is repeated, so `F80` means `FF8800`.
    /// - `RRGGBB` is an opaque color.
    /// - `RRGGBBAA` puts the alpha component last, as in CSS. It isn't the `AARRGGBB` order used by Android.
    ///
    /// Any other length, a non-hexadecimal character, a sign, whitespace or a second prefix returns `nil`.
    ///
    /// ```swift
    /// NSColor(hexString: "#FF8000")  // orange, (1.0, 0.502, 0.0)
    /// NSColor(hexString: "0x1f2d3c")  // (0.122, 0.176, 0.235)
    /// NSColor(hexString: "#F80")  // (1.0, 0.533, 0.0)
    /// NSColor(hexString: "#11223380")  // (0.067, 0.133, 0.2), alpha 0.502
    /// NSColor(hexString: "#F")  // nil
    /// NSColor(hexString: "FFFFFFF")  // nil
    /// ```
    ///
    /// - Parameter hexString: The hexadecimal representation of the color, such as `"#FF8000"`.
    convenience init?(hexString: String) {
        var digits = Substring(hexString)
        if digits.hasPrefix("#") {
            digits = digits.dropFirst()
        } else if digits.hasPrefix("0x") || digits.hasPrefix("0X") {
            digits = digits.dropFirst(2)
        }
        guard digits.allSatisfy({ $0.isASCII && $0.isHexDigit }), let value = UInt32(digits, radix: 16) else {
            return nil
        }
        let channels: [UInt32]
        switch digits.count {
        case 3: channels = [value >> 8, value >> 4, value, 0xF].map { ($0 & 0xF) * 0x11 }
        case 4: channels = [value >> 12, value >> 8, value >> 4, value].map { ($0 & 0xF) * 0x11 }
        case 6: channels = [value >> 16, value >> 8, value, 0xFF].map { $0 & 0xFF }
        case 8: channels = [value >> 24, value >> 16, value >> 8, value].map { $0 & 0xFF }
        default: return nil
        }
        self.init(
            srgbRed: CGFloat(channels[0]) / 255,
            green: CGFloat(channels[1]) / 255,
            blue: CGFloat(channels[2]) / 255,
            alpha: CGFloat(channels[3]) / 255
        )
    }
}
#endif
