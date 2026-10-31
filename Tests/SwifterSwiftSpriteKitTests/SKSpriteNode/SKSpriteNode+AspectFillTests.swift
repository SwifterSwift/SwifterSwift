// SKSpriteNode+AspectFillTests.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import Foundation
import SpriteKit
import SwifterSwiftSpriteKit
import Testing

@MainActor
struct SKSpriteNodeAspectFillTests {
    func makeSprite(textureWidth: Int, textureHeight: Int) -> SKSpriteNode {
        let pixels = Data(repeating: 255, count: textureWidth * textureHeight * 4)
        let texture = SKTexture(data: pixels, size: CGSize(width: textureWidth, height: textureHeight))
        return SKSpriteNode(texture: texture)
    }

    func expectSize(_ actual: CGSize, equals expected: CGSize, sourceLocation: SourceLocation = #_sourceLocation) {
        #expect(abs(actual.width - expected.width) < 1e-4, sourceLocation: sourceLocation)
        #expect(abs(actual.height - expected.height) < 1e-4, sourceLocation: sourceLocation)
    }

    @Test(arguments: [
        (40, 10, CGSize(width: 100, height: 100), CGSize(width: 400, height: 100)),
        (10, 40, CGSize(width: 100, height: 100), CGSize(width: 100, height: 400)),
        (30, 30, CGSize(width: 100, height: 50), CGSize(width: 100, height: 100)),
        (40, 10, CGSize(width: 80, height: 20), CGSize(width: 80, height: 20)),
        (40, 10, CGSize(width: 20, height: 20), CGSize(width: 80, height: 20)),
        (40, 10, CGSize(width: 1_000, height: 10), CGSize(width: 1_000, height: 250)),
        (1, 1_000, CGSize(width: 10, height: 10), CGSize(width: 10, height: 10_000))
    ])
    func resizesForTheTextureAspectRatio(textureWidth: Int, textureHeight: Int, target: CGSize, expected: CGSize) {
        let sprite = makeSprite(textureWidth: textureWidth, textureHeight: textureHeight)
        sprite.aspectFill(to: target)
        expectSize(sprite.size, equals: expected)
    }

    @Test
    func coversTheTargetInsteadOfFittingInIt() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 400, height: 100))
    }

    @Test(arguments: [(100.0, 100.0), (750, 1_334), (1, 1_000), (0.5, 0.25), (3, 7)])
    func keepsTheAspectRatio(targetWidth: Double, targetHeight: Double) {
        let sprite = makeSprite(textureWidth: 16, textureHeight: 9)
        let target = CGSize(width: targetWidth, height: targetHeight)
        sprite.aspectFill(to: target)
        let widthRatio = sprite.size.width / target.width
        let heightRatio = sprite.size.height / target.height
        // One side matches the target and the other one covers it.
        #expect(abs(min(widthRatio, heightRatio) - 1) < 1e-4)
        #expect(sprite.size.width >= target.width - 1e-4)
        #expect(sprite.size.height >= target.height - 1e-4)
        #expect(abs(sprite.size.width / sprite.size.height - 16.0 / 9.0) < 1e-4)
    }

    @Test
    func ignoresTheCurrentSize() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.size = CGSize(width: 300, height: 300)
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 400, height: 100))
    }

    @Test
    func givesTheSameResultWhenCalledAgain() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 400, height: 100))
    }

    @Test
    func handlesAZeroTargetSize() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFill(to: .zero)
        expectSize(sprite.size, equals: .zero)

        let other = makeSprite(textureWidth: 40, textureHeight: 10)
        other.aspectFill(to: CGSize(width: 100, height: 0))
        expectSize(other.size, equals: CGSize(width: 100, height: 25))
    }

    @Test(arguments: [
        CGSize(width: -1, height: 100),
        CGSize(width: 100, height: -1),
        CGSize(width: CGFloat.nan, height: 100),
        CGSize(width: 100, height: CGFloat.infinity),
        CGSize(width: -CGFloat.infinity, height: -CGFloat.infinity)
    ])
    func ignoresAnInvalidTargetSize(_ target: CGSize) {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFill(to: target)
        expectSize(sprite.size, equals: CGSize(width: 40, height: 10))
    }

    @Test
    func doesNothingWithoutATexture() {
        let sprite = SKSpriteNode(color: .black, size: CGSize(width: 30, height: 60))
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 30, height: 60))
    }

    @Test
    func doesNothingForATextureWithoutArea() {
        let sprite = SKSpriteNode(color: .black, size: CGSize(width: 30, height: 60))
        sprite.texture = SKTexture()
        #expect(sprite.texture != nil)
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 30, height: 60))
    }

    @Test
    func changesOnlyTheSize() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.position = CGPoint(x: 12, y: -8)
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        sprite.xScale = 2
        sprite.yScale = 0.5
        sprite.aspectFill(to: CGSize(width: 100, height: 100))
        #expect(sprite.position == CGPoint(x: 12, y: -8))
        #expect(sprite.anchorPoint == CGPoint(x: 0, y: 1))
        #expect(sprite.xScale == 2)
        #expect(sprite.yScale == 0.5)
    }
}
#endif
