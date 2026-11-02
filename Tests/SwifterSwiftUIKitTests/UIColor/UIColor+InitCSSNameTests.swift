// UIColor+InitCSSNameTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorInitCSSNameTests {
    /// The CSS Color Module Level 4 named colors, from https://www.w3.org/TR/css-color-4/#named-colors.
    static let namedColors: [(String, UInt32)] = [
        ("aliceblue", 0xF0F8FF),
        ("antiquewhite", 0xFAEBD7),
        ("aqua", 0x00FFFF),
        ("aquamarine", 0x7FFFD4),
        ("azure", 0xF0FFFF),
        ("beige", 0xF5F5DC),
        ("bisque", 0xFFE4C4),
        ("black", 0x000000),
        ("blanchedalmond", 0xFFEBCD),
        ("blue", 0x0000FF),
        ("blueviolet", 0x8A2BE2),
        ("brown", 0xA52A2A),
        ("burlywood", 0xDEB887),
        ("cadetblue", 0x5F9EA0),
        ("chartreuse", 0x7FFF00),
        ("chocolate", 0xD2691E),
        ("coral", 0xFF7F50),
        ("cornflowerblue", 0x6495ED),
        ("cornsilk", 0xFFF8DC),
        ("crimson", 0xDC143C),
        ("cyan", 0x00FFFF),
        ("darkblue", 0x00008B),
        ("darkcyan", 0x008B8B),
        ("darkgoldenrod", 0xB8860B),
        ("darkgray", 0xA9A9A9),
        ("darkgreen", 0x006400),
        ("darkgrey", 0xA9A9A9),
        ("darkkhaki", 0xBDB76B),
        ("darkmagenta", 0x8B008B),
        ("darkolivegreen", 0x556B2F),
        ("darkorange", 0xFF8C00),
        ("darkorchid", 0x9932CC),
        ("darkred", 0x8B0000),
        ("darksalmon", 0xE9967A),
        ("darkseagreen", 0x8FBC8F),
        ("darkslateblue", 0x483D8B),
        ("darkslategray", 0x2F4F4F),
        ("darkslategrey", 0x2F4F4F),
        ("darkturquoise", 0x00CED1),
        ("darkviolet", 0x9400D3),
        ("deeppink", 0xFF1493),
        ("deepskyblue", 0x00BFFF),
        ("dimgray", 0x696969),
        ("dimgrey", 0x696969),
        ("dodgerblue", 0x1E90FF),
        ("firebrick", 0xB22222),
        ("floralwhite", 0xFFFAF0),
        ("forestgreen", 0x228B22),
        ("fuchsia", 0xFF00FF),
        ("gainsboro", 0xDCDCDC),
        ("ghostwhite", 0xF8F8FF),
        ("gold", 0xFFD700),
        ("goldenrod", 0xDAA520),
        ("gray", 0x808080),
        ("green", 0x008000),
        ("greenyellow", 0xADFF2F),
        ("grey", 0x808080),
        ("honeydew", 0xF0FFF0),
        ("hotpink", 0xFF69B4),
        ("indianred", 0xCD5C5C),
        ("indigo", 0x4B0082),
        ("ivory", 0xFFFFF0),
        ("khaki", 0xF0E68C),
        ("lavender", 0xE6E6FA),
        ("lavenderblush", 0xFFF0F5),
        ("lawngreen", 0x7CFC00),
        ("lemonchiffon", 0xFFFACD),
        ("lightblue", 0xADD8E6),
        ("lightcoral", 0xF08080),
        ("lightcyan", 0xE0FFFF),
        ("lightgoldenrodyellow", 0xFAFAD2),
        ("lightgray", 0xD3D3D3),
        ("lightgreen", 0x90EE90),
        ("lightgrey", 0xD3D3D3),
        ("lightpink", 0xFFB6C1),
        ("lightsalmon", 0xFFA07A),
        ("lightseagreen", 0x20B2AA),
        ("lightskyblue", 0x87CEFA),
        ("lightslategray", 0x778899),
        ("lightslategrey", 0x778899),
        ("lightsteelblue", 0xB0C4DE),
        ("lightyellow", 0xFFFFE0),
        ("lime", 0x00FF00),
        ("limegreen", 0x32CD32),
        ("linen", 0xFAF0E6),
        ("magenta", 0xFF00FF),
        ("maroon", 0x800000),
        ("mediumaquamarine", 0x66CDAA),
        ("mediumblue", 0x0000CD),
        ("mediumorchid", 0xBA55D3),
        ("mediumpurple", 0x9370DB),
        ("mediumseagreen", 0x3CB371),
        ("mediumslateblue", 0x7B68EE),
        ("mediumspringgreen", 0x00FA9A),
        ("mediumturquoise", 0x48D1CC),
        ("mediumvioletred", 0xC71585),
        ("midnightblue", 0x191970),
        ("mintcream", 0xF5FFFA),
        ("mistyrose", 0xFFE4E1),
        ("moccasin", 0xFFE4B5),
        ("navajowhite", 0xFFDEAD),
        ("navy", 0x000080),
        ("oldlace", 0xFDF5E6),
        ("olive", 0x808000),
        ("olivedrab", 0x6B8E23),
        ("orange", 0xFFA500),
        ("orangered", 0xFF4500),
        ("orchid", 0xDA70D6),
        ("palegoldenrod", 0xEEE8AA),
        ("palegreen", 0x98FB98),
        ("paleturquoise", 0xAFEEEE),
        ("palevioletred", 0xDB7093),
        ("papayawhip", 0xFFEFD5),
        ("peachpuff", 0xFFDAB9),
        ("peru", 0xCD853F),
        ("pink", 0xFFC0CB),
        ("plum", 0xDDA0DD),
        ("powderblue", 0xB0E0E6),
        ("purple", 0x800080),
        ("rebeccapurple", 0x663399),
        ("red", 0xFF0000),
        ("rosybrown", 0xBC8F8F),
        ("royalblue", 0x4169E1),
        ("saddlebrown", 0x8B4513),
        ("salmon", 0xFA8072),
        ("sandybrown", 0xF4A460),
        ("seagreen", 0x2E8B57),
        ("seashell", 0xFFF5EE),
        ("sienna", 0xA0522D),
        ("silver", 0xC0C0C0),
        ("skyblue", 0x87CEEB),
        ("slateblue", 0x6A5ACD),
        ("slategray", 0x708090),
        ("slategrey", 0x708090),
        ("snow", 0xFFFAFA),
        ("springgreen", 0x00FF7F),
        ("steelblue", 0x4682B4),
        ("tan", 0xD2B48C),
        ("teal", 0x008080),
        ("thistle", 0xD8BFD8),
        ("tomato", 0xFF6347),
        ("turquoise", 0x40E0D0),
        ("violet", 0xEE82EE),
        ("wheat", 0xF5DEB3),
        ("white", 0xFFFFFF),
        ("whitesmoke", 0xF5F5F5),
        ("yellow", 0xFFFF00),
        ("yellowgreen", 0x9ACD32)
    ]

    @Test
    func knowsAll148Names() {
        #expect(Self.namedColors.count == 148)
        #expect(Set(Self.namedColors.map(\.0)).count == 148)
    }

    @Test(arguments: namedColors)
    func parsesEveryNamedColor(_ name: String, hex: UInt32) throws {
        let color = try #require(UIColor(cssName: name))
        #expect(bytes(of: color) == [Int(hex >> 16), Int((hex >> 8) & 0xFF), Int(hex & 0xFF), 0xFF])
    }

    @Test(arguments: ["transparent", "TRANSPARENT", "Transparent", " transparent\n"])
    func readsTransparentAsTransparentBlack(_ name: String) throws {
        let color = try #require(UIColor(cssName: name))
        #expect(bytes(of: color) == [0, 0, 0, 0])
    }

    @Test(
        arguments: [
            ("RED", 0xFF0000),
            ("Red", 0xFF0000),
            ("rEd", 0xFF0000),
            ("RebeccaPurple", 0x663399),
            ("aliceBlue", 0xF0F8FF),
            ("LIGHTGOLDENRODYELLOW", 0xFAFAD2),
            ("DarkSlateGrey", 0x2F4F4F)
        ] as [(String, UInt32)])
    func ignoresLetterCase(_ name: String, hex: UInt32) throws {
        let color = try #require(UIColor(cssName: name))
        #expect(bytes(of: color) == [Int(hex >> 16), Int((hex >> 8) & 0xFF), Int(hex & 0xFF), 0xFF])
    }

    @Test(arguments: [
        " red", "red ", "  red  ", "\tred\n", "\r\nred\r\n", "\u{A0}red\u{3000}", "\u{2028}red", "\u{85}red",
        "\u{2003}red\u{202F}"
    ])
    func ignoresSurroundingWhitespace(_ name: String) throws {
        let color = try #require(UIColor(cssName: name))
        #expect(bytes(of: color) == [0xFF, 0x00, 0x00, 0xFF])
    }

    @Test(
        arguments: [
            ("gray", "grey"), ("darkgray", "darkgrey"), ("darkslategray", "darkslategrey"), ("dimgray", "dimgrey"),
            ("lightgray", "lightgrey"), ("lightslategray", "lightslategrey"), ("slategray", "slategrey"),
            ("aqua", "cyan"), ("fuchsia", "magenta")
        ])
    func givesAliasesTheSameColor(_ name: String, alias: String) throws {
        let color = try #require(UIColor(cssName: name))
        let aliasColor = try #require(UIColor(cssName: alias))
        #expect(bytes(of: color) == bytes(of: aliasColor))
    }

    @Test
    func usesTheCSSValuesRatherThanTheSDKOnes() throws {
        // CSS `green` is half as bright as `UIColor.green`, which is CSS `lime`, and CSS `darkgray` is lighter than
        // CSS `gray`.
        #expect(bytes(of: try #require(UIColor(cssName: "green"))) == [0x00, 0x80, 0x00, 0xFF])
        #expect(bytes(of: try #require(UIColor(cssName: "lime"))) == [0x00, 0xFF, 0x00, 0xFF])
        #expect(bytes(of: try #require(UIColor(cssName: "darkgray"))) == [0xA9, 0xA9, 0xA9, 0xFF])
        #expect(bytes(of: try #require(UIColor(cssName: "gray"))) == [0x80, 0x80, 0x80, 0xFF])
    }

    @Test(arguments: [
        "", " ", "\n", "light blue", "light-blue", "light_blue", "red1", "redd", "re d", "r", "clear", "darkgreyish",
        "#FF0000", "FF0000", "0xFF0000", "#red", "rgb(255, 0, 0)", "red;", "\"red\"",
        "currentcolor", "inherit", "initial", "none", "canvas", "buttontext", "systemblue",
        "\u{212A}haki", "\u{FF32}\u{FF25}\u{FF24}", "\u{130}ndigo", "re\u{301}d", "red\u{301}", "\u{301}red",
        " \u{301}red", "r\u{200B}ed", "\u{200B}red", "red\u{FEFF}", "\u{1F9D1}\u{200D}\u{1F4BB}",
        "red\u{1F9D1}\u{200D}\u{1F4BB}"
    ])
    func returnsNilForUnknownNames(_ name: String) {
        // The zero-width space (U+200B) and the byte order mark (U+FEFF) aren't whitespace in Unicode, so they're kept.
        #expect(UIColor(cssName: name) == nil)
    }

    @Test
    func createsAnSRGBCompatibleColor() throws {
        // UIKit stores the color in extended sRGB, which matches sRGB for components in `0...1`.
        for name in ["tomato", "transparent"] {
            let space = try #require(UIColor(cssName: name)).cgColor.colorSpace?.name
            #expect(space == CGColorSpace.sRGB || space == CGColorSpace.extendedSRGB)
        }
    }

    /// The color's red, green, blue and alpha components, scaled to `0...255` and rounded.
    private func bytes(of color: UIColor) -> [Int] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        return [red, green, blue, alpha].map { Int(($0 * 255).rounded()) }
    }
}
#endif
