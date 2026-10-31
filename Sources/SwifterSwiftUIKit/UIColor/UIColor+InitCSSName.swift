// UIColor+InitCSSName.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: Creates a color from a CSS color name, or returns `nil` if the name is unknown.
    ///
    /// The names are the 148 named colors of CSS Color Module Level 4, from `aliceblue` to `yellowgreen`, including
    /// `rebeccapurple` and the `grey` spelling of every `gray` name. Each one gives the same sRGB value as in a web
    /// browser. The `transparent` keyword is accepted too, and gives transparent black, like `UIColor.clear`.
    ///
    /// As in CSS, letter case is ignored, so `"RebeccaPurple"` works too. Leading and trailing whitespace and newlines,
    /// as defined by Unicode, are ignored as well. Spaces or hyphens inside the name, non-ASCII lookalike letters, hex
    /// strings, `rgb()` functions and other CSS keywords, such as `currentcolor` or system colors, return `nil`.
    ///
    /// Some CSS colors differ from the SDK colors with the same name. CSS `green` is `#008000`, while `UIColor.green`
    /// is CSS `lime`. CSS `orange` is `#FFA500`, and CSS `darkgray` is lighter than CSS `gray`.
    ///
    /// ```swift
    /// UIColor(cssName: "rebeccapurple")  // (0.4, 0.2, 0.6)
    /// UIColor(cssName: "  Tomato\n")  // (1.0, 0.388, 0.278)
    /// UIColor(cssName: "transparent")  // (0.0, 0.0, 0.0), alpha 0.0
    /// UIColor(cssName: "light blue")  // nil
    /// ```
    ///
    /// - Parameter cssName: The name of the color, such as `"tomato"`.
    convenience init?(cssName: String) {
        let scalars = cssName.unicodeScalars
        guard let first = scalars.firstIndex(where: { !$0.properties.isWhitespace }),
            let last = scalars.lastIndex(where: { !$0.properties.isWhitespace })
        else { return nil }
        let name = scalars[first...last]
        // CSS ignores ASCII case only, so a lookalike such as the Kelvin sign in "\u{212A}haki" mustn't match "khaki".
        guard name.allSatisfy(\.isASCII) else { return nil }
        let hex: UInt32
        var alpha: CGFloat = 1
        switch String(name).lowercased() {
        case "aliceblue": hex = 0xF0F8FF
        case "antiquewhite": hex = 0xFAEBD7
        case "aqua": hex = 0x00FFFF
        case "aquamarine": hex = 0x7FFFD4
        case "azure": hex = 0xF0FFFF
        case "beige": hex = 0xF5F5DC
        case "bisque": hex = 0xFFE4C4
        case "black": hex = 0x000000
        case "blanchedalmond": hex = 0xFFEBCD
        case "blue": hex = 0x0000FF
        case "blueviolet": hex = 0x8A2BE2
        case "brown": hex = 0xA52A2A
        case "burlywood": hex = 0xDEB887
        case "cadetblue": hex = 0x5F9EA0
        case "chartreuse": hex = 0x7FFF00
        case "chocolate": hex = 0xD2691E
        case "coral": hex = 0xFF7F50
        case "cornflowerblue": hex = 0x6495ED
        case "cornsilk": hex = 0xFFF8DC
        case "crimson": hex = 0xDC143C
        case "cyan": hex = 0x00FFFF
        case "darkblue": hex = 0x00008B
        case "darkcyan": hex = 0x008B8B
        case "darkgoldenrod": hex = 0xB8860B
        case "darkgray", "darkgrey": hex = 0xA9A9A9
        case "darkgreen": hex = 0x006400
        case "darkkhaki": hex = 0xBDB76B
        case "darkmagenta": hex = 0x8B008B
        case "darkolivegreen": hex = 0x556B2F
        case "darkorange": hex = 0xFF8C00
        case "darkorchid": hex = 0x9932CC
        case "darkred": hex = 0x8B0000
        case "darksalmon": hex = 0xE9967A
        case "darkseagreen": hex = 0x8FBC8F
        case "darkslateblue": hex = 0x483D8B
        case "darkslategray", "darkslategrey": hex = 0x2F4F4F
        case "darkturquoise": hex = 0x00CED1
        case "darkviolet": hex = 0x9400D3
        case "deeppink": hex = 0xFF1493
        case "deepskyblue": hex = 0x00BFFF
        case "dimgray", "dimgrey": hex = 0x696969
        case "dodgerblue": hex = 0x1E90FF
        case "firebrick": hex = 0xB22222
        case "floralwhite": hex = 0xFFFAF0
        case "forestgreen": hex = 0x228B22
        case "fuchsia": hex = 0xFF00FF
        case "gainsboro": hex = 0xDCDCDC
        case "ghostwhite": hex = 0xF8F8FF
        case "gold": hex = 0xFFD700
        case "goldenrod": hex = 0xDAA520
        case "gray", "grey": hex = 0x808080
        case "green": hex = 0x008000
        case "greenyellow": hex = 0xADFF2F
        case "honeydew": hex = 0xF0FFF0
        case "hotpink": hex = 0xFF69B4
        case "indianred": hex = 0xCD5C5C
        case "indigo": hex = 0x4B0082
        case "ivory": hex = 0xFFFFF0
        case "khaki": hex = 0xF0E68C
        case "lavender": hex = 0xE6E6FA
        case "lavenderblush": hex = 0xFFF0F5
        case "lawngreen": hex = 0x7CFC00
        case "lemonchiffon": hex = 0xFFFACD
        case "lightblue": hex = 0xADD8E6
        case "lightcoral": hex = 0xF08080
        case "lightcyan": hex = 0xE0FFFF
        case "lightgoldenrodyellow": hex = 0xFAFAD2
        case "lightgray", "lightgrey": hex = 0xD3D3D3
        case "lightgreen": hex = 0x90EE90
        case "lightpink": hex = 0xFFB6C1
        case "lightsalmon": hex = 0xFFA07A
        case "lightseagreen": hex = 0x20B2AA
        case "lightskyblue": hex = 0x87CEFA
        case "lightslategray", "lightslategrey": hex = 0x778899
        case "lightsteelblue": hex = 0xB0C4DE
        case "lightyellow": hex = 0xFFFFE0
        case "lime": hex = 0x00FF00
        case "limegreen": hex = 0x32CD32
        case "linen": hex = 0xFAF0E6
        case "magenta": hex = 0xFF00FF
        case "maroon": hex = 0x800000
        case "mediumaquamarine": hex = 0x66CDAA
        case "mediumblue": hex = 0x0000CD
        case "mediumorchid": hex = 0xBA55D3
        case "mediumpurple": hex = 0x9370DB
        case "mediumseagreen": hex = 0x3CB371
        case "mediumslateblue": hex = 0x7B68EE
        case "mediumspringgreen": hex = 0x00FA9A
        case "mediumturquoise": hex = 0x48D1CC
        case "mediumvioletred": hex = 0xC71585
        case "midnightblue": hex = 0x191970
        case "mintcream": hex = 0xF5FFFA
        case "mistyrose": hex = 0xFFE4E1
        case "moccasin": hex = 0xFFE4B5
        case "navajowhite": hex = 0xFFDEAD
        case "navy": hex = 0x000080
        case "oldlace": hex = 0xFDF5E6
        case "olive": hex = 0x808000
        case "olivedrab": hex = 0x6B8E23
        case "orange": hex = 0xFFA500
        case "orangered": hex = 0xFF4500
        case "orchid": hex = 0xDA70D6
        case "palegoldenrod": hex = 0xEEE8AA
        case "palegreen": hex = 0x98FB98
        case "paleturquoise": hex = 0xAFEEEE
        case "palevioletred": hex = 0xDB7093
        case "papayawhip": hex = 0xFFEFD5
        case "peachpuff": hex = 0xFFDAB9
        case "peru": hex = 0xCD853F
        case "pink": hex = 0xFFC0CB
        case "plum": hex = 0xDDA0DD
        case "powderblue": hex = 0xB0E0E6
        case "purple": hex = 0x800080
        case "rebeccapurple": hex = 0x663399
        case "red": hex = 0xFF0000
        case "rosybrown": hex = 0xBC8F8F
        case "royalblue": hex = 0x4169E1
        case "saddlebrown": hex = 0x8B4513
        case "salmon": hex = 0xFA8072
        case "sandybrown": hex = 0xF4A460
        case "seagreen": hex = 0x2E8B57
        case "seashell": hex = 0xFFF5EE
        case "sienna": hex = 0xA0522D
        case "silver": hex = 0xC0C0C0
        case "skyblue": hex = 0x87CEEB
        case "slateblue": hex = 0x6A5ACD
        case "slategray", "slategrey": hex = 0x708090
        case "snow": hex = 0xFFFAFA
        case "springgreen": hex = 0x00FF7F
        case "steelblue": hex = 0x4682B4
        case "tan": hex = 0xD2B48C
        case "teal": hex = 0x008080
        case "thistle": hex = 0xD8BFD8
        case "tomato": hex = 0xFF6347
        case "turquoise": hex = 0x40E0D0
        case "violet": hex = 0xEE82EE
        case "wheat": hex = 0xF5DEB3
        case "white": hex = 0xFFFFFF
        case "whitesmoke": hex = 0xF5F5F5
        case "yellow": hex = 0xFFFF00
        case "yellowgreen": hex = 0x9ACD32
        case "transparent":
            hex = 0x000000
            alpha = 0
        default: return nil
        }
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: alpha
        )
    }
}
#endif
