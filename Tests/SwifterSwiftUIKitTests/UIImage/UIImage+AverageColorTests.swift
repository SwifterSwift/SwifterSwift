// UIImage+AverageColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && canImport(CoreImage)
import CoreGraphics
import CoreImage
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageAverageColorTests {
    private let context = CIContext()

    @Test(arguments: [
        [1.0, 0, 0, 1],
        [0, 0, 1, 1],
        [1, 0.5, 0, 1],
        [0.2, 0.4, 0.6, 1],
        [1, 1, 1, 1],
        [0, 0, 0, 1]
    ])
    func returnsTheColorOfASolidImage(_ components: [CGFloat]) throws {
        let color = UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
        let image = makeImage { context in
            color.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 10, height: 6))
        }
        let average = try #require(image.averageColor(using: context))
        #expect(isClose(average, to: components))
    }

    @Test
    func averagesInLinearLightByDefault() throws {
        let average = try #require(makeRedAndGreenImage().averageColor(using: context))
        #expect(isClose(average, to: [0.735, 0.735, 0, 1]))
        #expect(isClose(try #require(makeRedAndGreenImage().averageColor()), to: [0.735, 0.735, 0, 1]))
    }

    @Test
    func averagesStoredValuesInAnSRGBWorkingSpace() throws {
        let sRGB = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let gammaContext = CIContext(options: [.workingColorSpace: sRGB])
        let average = try #require(makeRedAndGreenImage().averageColor(using: gammaContext))
        #expect(isClose(average, to: [0.5, 0.5, 0, 1]))
    }

    @Test
    func ignoresTheColorOfTransparentPixels() throws {
        let image = makeImage { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 5, height: 6))
        }
        let average = try #require(image.averageColor(using: context))
        #expect(isClose(average, to: [1, 0, 0, 0.5]))
    }

    @Test
    func returnsAClearColorForATransparentImage() throws {
        let average = try #require(makeImage { _ in }.averageColor(using: context))
        #expect(isClose(average, to: [0, 0, 0, 0]))
    }

    @Test
    func readsImagesBackedByACIImage() throws {
        let ciImage = CIImage(color: CIColor(red: 0, green: 0, blue: 1))
            .cropped(to: CGRect(x: 10, y: 20, width: 8, height: 8))
        let average = try #require(UIImage(ciImage: ciImage).averageColor(using: context))
        #expect(isClose(average, to: [0, 0, 1, 1]))
    }

    @Test
    func returnsNilForImagesWithoutPixels() {
        #expect(UIImage().averageColor(using: context) == nil)
        let infinite = CIImage(color: CIColor(red: 0, green: 0, blue: 1))
        #expect(UIImage(ciImage: infinite).averageColor(using: context) == nil)
    }

    @Test
    func givesTheSameResultWhenTheContextIsReused() throws {
        let image = makeRedAndGreenImage()
        let first = try #require(image.averageColor(using: context))
        let second = try #require(image.averageColor(using: context))
        #expect(first == second)
    }

    /// Returns a 10 × 6 image whose left half is red and right half is green.
    private func makeRedAndGreenImage() -> UIImage {
        makeImage { context in
            UIColor(red: 1, green: 0, blue: 0, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: 0, width: 5, height: 6))
            UIColor(red: 0, green: 1, blue: 0, alpha: 1).setFill()
            context.fill(CGRect(x: 5, y: 0, width: 5, height: 6))
        }
    }

    /// Returns a 10 × 6 image drawn by `actions` into an 8-bit sRGB bitmap.
    private func makeImage(actions: (UIGraphicsImageRendererContext) -> Void) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.preferredRange = .standard
        return UIGraphicsImageRenderer(size: CGSize(width: 10, height: 6), format: format).image(actions: actions)
    }

    /// Returns whether a color's sRGB components match the expected red, green, blue and alpha.
    private func isClose(_ color: UIColor, to expected: [CGFloat]) -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return false }
        return zip([red, green, blue, alpha], expected).allSatisfy { abs($0 - $1) <= 0.01 }
    }
}
#endif
