// Locale.Region+FlagEmojiTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct LocaleRegionFlagEmojiTests {
    @Test(arguments: [
        ("US", "🇺🇸"), ("FR", "🇫🇷"), ("JP", "🇯🇵"), ("BR", "🇧🇷"), ("ZW", "🇿🇼"), ("AC", "🇦🇨"), ("EU", "🇪🇺"),
        ("UN", "🇺🇳"), ("XK", "🇽🇰")
    ])
    func returnsTheFlagForTwoLetterCodes(_ code: String, _ flag: String) {
        #expect(Locale.Region(code).flagEmoji == flag)
    }

    @Test(arguments: ["us", "Us", "uS"])
    func matchesCodesCaseInsensitively(_ code: String) {
        #expect(Locale.Region(code).flagEmoji == "🇺🇸")
    }

    @Test
    func isASingleCharacterMadeOfTwoRegionalIndicators() throws {
        let flag = try #require(Locale.Region("GB").flagEmoji)
        #expect(flag.count == 1)
        #expect(flag.unicodeScalars.map(\.value) == [0x1F1EC, 0x1F1E7])
    }

    @Test
    func worksWithTheRegionOfALocale() {
        #expect(Locale(identifier: "pt_BR").region?.flagEmoji == "🇧🇷")
        #expect(Locale(identifier: "zh-Hant-TW").region?.flagEmoji == "🇹🇼")
        #expect(Locale(identifier: "es_419").region?.flagEmoji == nil)
    }

    @Test(arguments: ["", "419", "001", "840", "USA", "ZZ", "AA", "XA", "U", "UK", "é", "🇺🇸", "U1", "ÉÉ"])
    func returnsNilForCodesWithoutAFlag(_ code: String) {
        #expect(Locale.Region(code).flagEmoji == nil)
    }

    @Test
    func returnsAFlagForEveryTwoLetterISORegion() {
        let twoLetterRegions = Locale.Region.isoRegions.filter { region in
            region.identifier.unicodeScalars.count == 2 && region.identifier.allSatisfy(\.isLetter)
        }
        #expect(twoLetterRegions.count > 240)
        for region in twoLetterRegions {
            #expect(region.flagEmoji?.unicodeScalars.count == 2)
        }
    }
}
#endif
