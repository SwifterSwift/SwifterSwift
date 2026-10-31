// NSImage+ScaledToMaxSizeTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreGraphics
import SwifterSwiftAppKit
import Testing

struct NSImageScaledToMaxSizeTests {
    @Test(arguments: [
        (NSSize(width: 200, height: 100), NSSize(width: 300, height: 50), NSSize(width: 100, height: 50)),
        (NSSize(width: 200, height: 100), NSSize(width: 150, height: 150), NSSize(width: 150, height: 75)),
        (NSSize(width: 100, height: 200), NSSize(width: 150, height: 150), NSSize(width: 75, height: 150)),
        (NSSize(width: 200, height: 100), NSSize(width: 50, height: 300), NSSize(width: 50, height: 25)),
        (NSSize(width: 1000, height: 232), NSSize(width: 150, height: 150), NSSize(width: 150, height: 34)),
        (NSSize(width: 300, height: 300), NSSize(width: 100, height: 40), NSSize(width: 40, height: 40))
    ])
    func fitsBothSidesWithinTheMaximum(size: NSSize, maxSize: NSSize, expected: NSSize) throws {
        let image = try makeImage(pixelsWide: Int(size.width), pixelsHigh: Int(size.height), size: size)
        let scaled = try #require(image.scaled(toMaxSize: maxSize))
        #expect(scaled.size == expected)
        #expect(scaled.size.width <= maxSize.width)
        #expect(scaled.size.height <= maxSize.height)
    }

    @Test(arguments: [
        NSSize(width: 1000, height: 1000), NSSize(width: 200, height: 100), NSSize(width: 200, height: 500),
        NSSize(width: CGFloat.infinity, height: CGFloat.infinity)
    ])
    func neverEnlargesTheImage(_ maxSize: NSSize) throws {
        let image = try makeImage(pixelsWide: 200, pixelsHigh: 100, size: NSSize(width: 200, height: 100))
        let scaled = try #require(image.scaled(toMaxSize: maxSize))
        #expect(scaled.size == NSSize(width: 200, height: 100))
    }

    @Test
    func resamplesTheBitmap() throws {
        let image = try makeImage(pixelsWide: 200, pixelsHigh: 100, size: NSSize(width: 200, height: 100))
        let scaled = try #require(image.scaled(toMaxSize: NSSize(width: 20, height: 20)))
        let cgImage = try bitmap(of: scaled)
        #expect(cgImage.width == 20)
        #expect(cgImage.height == 10)
        let row = try pixels(of: cgImage)[5]
        #expect(isClose(row[0], to: [255, 0, 0, 255]))
        #expect(isClose(row[19], to: [0, 0, 255, 255]))
    }

    @Test
    func keepsThePixelDensity() throws {
        let image = try makeImage(pixelsWide: 400, pixelsHigh: 200, size: NSSize(width: 200, height: 100))
        let scaled = try #require(image.scaled(toMaxSize: NSSize(width: 100, height: 100)))
        #expect(scaled.size == NSSize(width: 100, height: 50))
        let cgImage = try bitmap(of: scaled)
        #expect(cgImage.width == 200)
        #expect(cgImage.height == 100)
    }

    @Test
    func usesTheSharpestRepresentation() throws {
        let image = NSImage(size: NSSize(width: 200, height: 100))
        image.addRepresentation(NSBitmapImageRep(cgImage: try makeCGImage(pixelsWide: 200, pixelsHigh: 100)))
        let retina = NSBitmapImageRep(cgImage: try makeCGImage(pixelsWide: 400, pixelsHigh: 200))
        retina.size = NSSize(width: 200, height: 100)
        image.addRepresentation(retina)

        let scaled = try #require(image.scaled(toMaxSize: NSSize(width: 100, height: 100)))
        #expect(scaled.size == NSSize(width: 100, height: 50))
        #expect(try bitmap(of: scaled).width == 200)
    }

    @Test
    func drawsImagesMadeByADrawingHandler() throws {
        let image = NSImage(size: NSSize(width: 40, height: 20), flipped: false) { rect in
            NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1).setFill()
            rect.fill()
            return true
        }
        let scaled = try #require(image.scaled(toMaxSize: NSSize(width: 20, height: 20)))
        #expect(scaled.size == NSSize(width: 20, height: 10))
        let cgImage = try bitmap(of: scaled)
        let pixel = try pixels(of: cgImage)[5][10]
        #expect(isClose(pixel, to: [0, 255, 0, 255]))
    }

    @Test
    func keepsAtLeastOnePointOnEachSide() throws {
        let image = try makeImage(pixelsWide: 1000, pixelsHigh: 1, size: NSSize(width: 1000, height: 1))
        let scaled = try #require(image.scaled(toMaxSize: NSSize(width: 100, height: 100)))
        #expect(scaled.size == NSSize(width: 100, height: 1))
    }

    @Test(arguments: [
        NSSize.zero, NSSize(width: 0.5, height: 100), NSSize(width: 100, height: 0), NSSize(width: -10, height: 100),
        NSSize(width: CGFloat.nan, height: 100), NSSize(width: 100, height: -CGFloat.infinity)
    ])
    func returnsNilForInvalidMaximum(_ maxSize: NSSize) throws {
        let image = try makeImage(pixelsWide: 200, pixelsHigh: 100, size: NSSize(width: 200, height: 100))
        #expect(image.scaled(toMaxSize: maxSize) == nil)
    }

    @Test
    func returnsNilForImagesWithoutPixels() {
        #expect(NSImage().scaled(toMaxSize: NSSize(width: 100, height: 100)) == nil)
        #expect(NSImage(size: NSSize(width: 10, height: 10)).scaled(toMaxSize: NSSize(width: 100, height: 100)) == nil)
    }

    /// Returns an image whose left half is red and right half is blue, with the given pixel and point sizes.
    private func makeImage(pixelsWide: Int, pixelsHigh: Int, size: NSSize) throws -> NSImage {
        NSImage(cgImage: try makeCGImage(pixelsWide: pixelsWide, pixelsHigh: pixelsHigh), size: size)
    }

    /// Returns a bitmap whose left half is red and right half is blue.
    private func makeCGImage(pixelsWide: Int, pixelsHigh: Int) throws -> CGImage {
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: pixelsWide / 2, height: pixelsHigh))
        context.setFillColor(red: 0, green: 0, blue: 1, alpha: 1)
        context.fill(CGRect(x: pixelsWide / 2, y: 0, width: pixelsWide - pixelsWide / 2, height: pixelsHigh))
        return try #require(context.makeImage())
    }

    /// Returns the image's bitmap, whatever the screen's resolution.
    private func bitmap(of image: NSImage) throws -> CGImage {
        var rect = CGRect(origin: .zero, size: image.size)
        return try #require(image.cgImage(forProposedRect: &rect, context: nil, hints: [.ctm: NSAffineTransform()]))
    }

    /// Returns the 8-bit sRGB components of every pixel of a bitmap, by row from the top-left corner.
    private func pixels(of cgImage: CGImage) throws -> [[[Int]]] {
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        let data = try #require(context.data).assumingMemoryBound(to: UInt8.self)
        return (0..<height).map { y in
            (0..<width).map { x in (0..<4).map { Int(data[(y * width + x) * 4 + $0]) } }
        }
    }

    /// Returns whether two pixels match, allowing for rounding in each component.
    private func isClose(_ pixel: [Int], to expected: [Int], tolerance: Int = 2) -> Bool {
        pixel.count == expected.count && zip(pixel, expected).allSatisfy { abs($0 - $1) <= tolerance }
    }
}
#endif
