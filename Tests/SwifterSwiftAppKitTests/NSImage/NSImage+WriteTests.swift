// NSImage+WriteTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreGraphics
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSImageWriteTests {
    @Test
    func writesAPNGFile() throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image.png")
            let image = try makeImage(pixelsWide: 8, pixelsHigh: 4, size: NSSize(width: 8, height: 4))
            try image.write(to: url, fileType: .png)

            let written = try #require(NSBitmapImageRep(data: try Data(contentsOf: url))?.cgImage)
            #expect(written.width == 8)
            #expect(written.height == 4)
            #expect(try pixels(of: written) == pixels(of: try makeCGImage(pixelsWide: 8, pixelsHigh: 4)))
        }
    }

    @Test(arguments: [1.0, 0.5, 0])
    func writesAJPEGFileByDefault(compressionFactor: Double) throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image.jpg")
            let image = try makeImage(pixelsWide: 32, pixelsHigh: 16, size: NSSize(width: 32, height: 16))
            try image.write(to: url, compressionFactor: compressionFactor)

            let data = try Data(contentsOf: url)
            #expect(data.starts(with: [0xFF, 0xD8, 0xFF]))
            let written = try #require(NSBitmapImageRep(data: data)?.cgImage)
            #expect(written.width == 32)
            #expect(written.height == 16)
            let row = try pixels(of: written)[8]
            #expect(isClose(row[2], to: [255, 0, 0, 255], tolerance: 40))
            #expect(isClose(row[29], to: [0, 0, 255, 255], tolerance: 40))
        }
    }

    @Test(arguments: [NSBitmapImageRep.FileType.tiff, .bmp, .gif, .jpeg2000])
    func writesOtherBitmapFormats(_ fileType: NSBitmapImageRep.FileType) throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image")
            let image = try makeImage(pixelsWide: 8, pixelsHigh: 4, size: NSSize(width: 8, height: 4))
            try image.write(to: url, fileType: fileType)
            let written = try #require(NSBitmapImageRep(data: try Data(contentsOf: url)))
            #expect(written.pixelsWide == 8)
            #expect(written.pixelsHigh == 4)
        }
    }

    @Test
    func keepsTheSizeInPointsOfHighResolutionImages() throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image@2x.png")
            let image = try makeImage(pixelsWide: 400, pixelsHigh: 200, size: NSSize(width: 200, height: 100))
            try image.write(to: url, fileType: .png)

            let written = try #require(NSImage(contentsOf: url))
            #expect(written.size == NSSize(width: 200, height: 100))
            #expect(written.representations.first?.pixelsWide == 400)
        }
    }

    @Test
    func writesTheSharpestRepresentation() throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image.png")
            let image = NSImage(size: NSSize(width: 200, height: 100))
            image.addRepresentation(NSBitmapImageRep(cgImage: try makeCGImage(pixelsWide: 200, pixelsHigh: 100)))
            let retina = NSBitmapImageRep(cgImage: try makeCGImage(pixelsWide: 400, pixelsHigh: 200))
            retina.size = NSSize(width: 200, height: 100)
            image.addRepresentation(retina)
            try image.write(to: url, fileType: .png)

            let written = try #require(NSBitmapImageRep(data: try Data(contentsOf: url)))
            #expect(written.pixelsWide == 400)
            #expect(written.pixelsHigh == 200)
        }
    }

    @Test
    func replacesAnExistingFile() throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image.png")
            try makeImage(pixelsWide: 8, pixelsHigh: 4, size: NSSize(width: 8, height: 4)).write(
                to: url, fileType: .png)
            try makeImage(pixelsWide: 2, pixelsHigh: 6, size: NSSize(width: 2, height: 6)).write(
                to: url, fileType: .png)
            let written = try #require(NSBitmapImageRep(data: try Data(contentsOf: url)))
            #expect(written.pixelsWide == 2)
            #expect(written.pixelsHigh == 6)
        }
    }

    @Test
    func throwsWhenTheFolderDoesNotExist() throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("missing").appendingPathComponent("image.png")
            let image = try makeImage(pixelsWide: 8, pixelsHigh: 4, size: NSSize(width: 8, height: 4))
            #expect(throws: (any Error).self) { try image.write(to: url, fileType: .png) }
            #expect(!FileManager.default.fileExists(atPath: url.path))
        }
    }

    @Test
    func throwsForImagesWithoutPixels() throws {
        try withTemporaryDirectory { directory in
            let url = directory.appendingPathComponent("image.png")
            for image in [NSImage(), NSImage(size: NSSize(width: 10, height: 10))] {
                let error = #expect(throws: CocoaError.self) { try image.write(to: url, fileType: .png) }
                #expect(error?.code == .fileWriteUnknown)
            }
            #expect(!FileManager.default.fileExists(atPath: url.path))
        }
    }

    /// Calls `body` with a new, empty temporary directory, and deletes the directory afterwards.
    private func withTemporaryDirectory(_ body: (URL) throws -> Void) throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        try body(directory)
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
