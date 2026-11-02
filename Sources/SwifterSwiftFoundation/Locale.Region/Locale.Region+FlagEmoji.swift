// Locale.Region+FlagEmoji.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Locale.Region {
    /// SwifterSwift: The flag emoji of the region, built from its two-letter code.
    ///
    /// A flag emoji is a pair of regional indicator symbols, one for each letter of the region's ISO 3166-1 alpha-2
    /// code, so `"US"` becomes 🇺🇸. The code is matched case-insensitively, so `Locale.Region("us")` works too.
    ///
    /// Only two-letter codes that Foundation lists in `Locale.Region.isoRegions` have a flag. Numeric UN M.49 codes
    /// (`"419"` for Latin America, `"001"` for the world), unknown codes such as `"ZZ"`, and malformed identifiers return
    /// `nil`. Some listed codes, such as `"EU"` and `"UN"`, aren't countries but still have flags. A few others, such as
    /// `"QO"` (Outlying Oceania), have no flag artwork, so most fonts draw their sequence as two boxed letters.
    ///
    /// ```swift
    /// Locale.Region("FR").flagEmoji  // "🇫🇷"
    /// Locale.Region("jp").flagEmoji  // "🇯🇵"
    /// Locale(identifier: "pt_BR").region?.flagEmoji  // "🇧🇷"
    /// Locale.Region.latinAmerica.flagEmoji  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of regions in `Locale.Region.isoRegions` (about 300).
    var flagEmoji: String? {
        let code = identifier.uppercased()
        let scalars = code.unicodeScalars
        guard scalars.count == 2, scalars.allSatisfy({ ("A"..."Z").contains($0) }),
            Locale.Region.isoRegions.contains(where: { $0.identifier == code })
        else { return nil }

        // The regional indicator symbols 🇦 to 🇿 (U+1F1E6 to U+1F1FF) follow the order of A to Z.
        var flag = String.UnicodeScalarView()
        for scalar in scalars {
            guard let indicator = Unicode.Scalar(0x1F1E6 + scalar.value - 0x41) else { return nil }
            flag.append(indicator)
        }
        return String(flag)
    }
}
#endif
