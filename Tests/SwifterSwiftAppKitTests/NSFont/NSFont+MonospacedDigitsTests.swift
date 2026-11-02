// NSFont+MonospacedDigitsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreText
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSFontMonospacedDigitsTests {
    @Test
    func requestsMonospacedNumbers() throws {
        let font = NSFont.systemFont(ofSize: 13).monospacedDigits
        let settings = try #require(
            font.fontDescriptor.object(forKey: .featureSettings) as? [[NSFontDescriptor.FeatureKey: Any]]
        )
        let numberSpacing = settings.filter { ($0[.typeIdentifier] as? Int) == kNumberSpacingType }
        #expect(numberSpacing.count == 1)
        #expect(numberSpacing.first?[.selectorIdentifier] as? Int == kMonospacedNumbersSelector)
    }

    @Test
    func givesEveryDigitTheSameWidth() {
        let font = NSFont.systemFont(ofSize: 20).monospacedDigits
        let widths = Set("0123456789".map { String($0).size(withAttributes: [.font: font]).width })
        #expect(widths.count == 1)
    }

    @Test
    func keepsTheSizeAndTraits() {
        let monospaced = NSFont.boldSystemFont(ofSize: 17).monospacedDigits
        #expect(monospaced.pointSize == 17)
        #expect(monospaced.fontDescriptor.symbolicTraits.contains(.bold))
    }

    @Test
    func keepsTheFace() throws {
        let font = try #require(NSFont(name: "Helvetica-Oblique", size: 15))
        let monospaced = font.monospacedDigits
        #expect(monospaced.fontName == "Helvetica-Oblique")
        #expect(monospaced.pointSize == 15)
    }

    @Test
    func keepsOtherFeatureSettings() throws {
        let smallCaps: [NSFontDescriptor.FeatureKey: Any] = [
            .typeIdentifier: kLowerCaseType,
            .selectorIdentifier: kLowerCaseSmallCapsSelector
        ]
        let base = NSFont.systemFont(ofSize: 13)
        let descriptor = base.fontDescriptor.addingAttributes([.featureSettings: [smallCaps]])
        let font = try #require(NSFont(descriptor: descriptor, size: 0)).monospacedDigits
        let settings = try #require(
            font.fontDescriptor.object(forKey: .featureSettings) as? [[NSFontDescriptor.FeatureKey: Any]]
        )
        #expect(settings.contains { ($0[.typeIdentifier] as? Int) == kLowerCaseType })
        #expect(settings.contains { ($0[.typeIdentifier] as? Int) == kNumberSpacingType })
    }

    @Test
    func replacesAnExistingNumberSpacingSetting() throws {
        let proportional: [NSFontDescriptor.FeatureKey: Any] = [
            .typeIdentifier: kNumberSpacingType,
            .selectorIdentifier: kProportionalNumbersSelector
        ]
        let base = NSFont.systemFont(ofSize: 13)
        let descriptor = base.fontDescriptor.addingAttributes([.featureSettings: [proportional]])
        let font = try #require(NSFont(descriptor: descriptor, size: 0)).monospacedDigits.monospacedDigits
        let settings = try #require(
            font.fontDescriptor.object(forKey: .featureSettings) as? [[NSFontDescriptor.FeatureKey: Any]]
        )
        let numberSpacing = settings.filter { ($0[.typeIdentifier] as? Int) == kNumberSpacingType }
        #expect(numberSpacing.count == 1)
        #expect(numberSpacing.first?[.selectorIdentifier] as? Int == kMonospacedNumbersSelector)
    }

    @Test
    func worksOnTextStyleFonts() {
        let font = NSFont.preferredFont(forTextStyle: .title1)
        let monospaced = font.monospacedDigits
        #expect(monospaced.pointSize == font.pointSize)
        let widths = Set(["1", "8"].map { $0.size(withAttributes: [.font: monospaced]).width })
        #expect(widths.count == 1)
    }
}
#endif
