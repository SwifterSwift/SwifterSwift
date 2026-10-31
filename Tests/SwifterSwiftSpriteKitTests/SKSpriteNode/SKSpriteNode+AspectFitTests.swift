// SKSpriteNode+AspectFitTests.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import Foundation
import SpriteKit
import SwifterSwiftSpriteKit
import Testing

@MainActor
struct SKSpriteNodeAspectFitTests {
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
        (40, 10, CGSize(width: 100, height: 100), CGSize(width: 100, height: 25)),
        (10, 40, CGSize(width: 100, height: 100), CGSize(width: 25, height: 100)),
        (30, 30, CGSize(width: 100, height: 50), CGSize(width: 50, height: 50)),
        (40, 10, CGSize(width: 80, height: 20), CGSize(width: 80, height: 20)),
        (40, 10, CGSize(width: 20, height: 20), CGSize(width: 20, height: 5)),
        (40, 10, CGSize(width: 1_000, height: 10), CGSize(width: 40, height: 10)),
        (1, 1_000, CGSize(width: 10, height: 10), CGSize(width: 0.01, height: 10))
    ])
    func resizesForTheTextureAspectRatio(textureWidth: Int, textureHeight: Int, target: CGSize, expected: CGSize) {
        let sprite = makeSprite(textureWidth: textureWidth, textureHeight: textureHeight)
        sprite.aspectFit(to: target)
        expectSize(sprite.size, equals: expected)
    }

    @Test
    func fitsInTheTargetInsteadOfCoveringIt() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 100, height: 25))
    }

    @Test(arguments: [(100.0, 100.0), (750, 1_334), (1, 1_000), (0.5, 0.25), (3, 7)])
    func keepsTheAspectRatio(targetWidth: Double, targetHeight: Double) {
        let sprite = makeSprite(textureWidth: 16, textureHeight: 9)
        let target = CGSize(width: targetWidth, height: targetHeight)
        sprite.aspectFit(to: target)
        let widthRatio = sprite.size.width / target.width
        let heightRatio = sprite.size.height / target.height
        // One side matches the target and the other one fits in it.
        #expect(abs(max(widthRatio, heightRatio) - 1) < 1e-4)
        #expect(sprite.size.width <= target.width + 1e-4)
        #expect(sprite.size.height <= target.height + 1e-4)
        #expect(abs(sprite.size.width / sprite.size.height - 16.0 / 9.0) < 1e-4)
    }

    @Test
    func ignoresTheCurrentSize() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.size = CGSize(width: 300, height: 300)
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 100, height: 25))
    }

    @Test
    func givesTheSameResultWhenCalledAgain() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 100, height: 25))
    }

    @Test
    func handlesAZeroTargetSize() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.aspectFit(to: .zero)
        expectSize(sprite.size, equals: .zero)

        let other = makeSprite(textureWidth: 40, textureHeight: 10)
        other.aspectFit(to: CGSize(width: 100, height: 0))
        expectSize(other.size, equals: CGSize(width: 0, height: 0))
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
        sprite.aspectFit(to: target)
        expectSize(sprite.size, equals: CGSize(width: 40, height: 10))
    }

    @Test
    func doesNothingWithoutATexture() {
        let sprite = SKSpriteNode(color: .black, size: CGSize(width: 30, height: 60))
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 30, height: 60))
    }

    @Test
    func doesNothingForATextureWithoutArea() {
        let sprite = SKSpriteNode(color: .black, size: CGSize(width: 30, height: 60))
        sprite.texture = SKTexture()
        #expect(sprite.texture != nil)
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        expectSize(sprite.size, equals: CGSize(width: 30, height: 60))
    }

    @Test
    func changesOnlyTheSize() {
        let sprite = makeSprite(textureWidth: 40, textureHeight: 10)
        sprite.position = CGPoint(x: 12, y: -8)
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        sprite.xScale = 2
        sprite.yScale = 0.5
        sprite.aspectFit(to: CGSize(width: 100, height: 100))
        #expect(sprite.position == CGPoint(x: 12, y: -8))
        #expect(sprite.anchorPoint == CGPoint(x: 0, y: 1))
        #expect(sprite.xScale == 2)
        #expect(sprite.yScale == 0.5)
    }
}
#endif
