// Collection+ChunkedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CollectionChunkedTests {
    @Test(arguments: [
        (1, [[1], [2], [3], [4], [5]]),
        (2, [[1, 2], [3, 4], [5]]),
        (3, [[1, 2, 3], [4, 5]]),
        (5, [[1, 2, 3, 4, 5]]),
        (6, [[1, 2, 3, 4, 5]]),
        (Int.max, [[1, 2, 3, 4, 5]])
    ])
    func splitsIntoChunksOfTheGivenSize(_ size: Int, expected: [[Int]]) {
        let chunks = [1, 2, 3, 4, 5].chunked(into: size)
        #expect(chunks.map { Array($0) } == expected)
    }

    @Test(arguments: [0, -1, Int.min])
    func returnsNoChunksForInvalidSize(_ size: Int) {
        #expect([1, 2, 3].chunked(into: size).isEmpty)
    }

    @Test(arguments: [1, 3, Int.max, 0, -1])
    func returnsNoChunksForEmptyCollection(_ size: Int) {
        #expect([Int]().chunked(into: size).isEmpty)
    }

    @Test
    func returnsSlicesThatKeepTheIndicesOfTheCollection() {
        let chunks = [10, 20, 30, 40, 50].chunked(into: 2)
        #expect(chunks.map(\.startIndex) == [0, 2, 4])

        let slice = [10, 20, 30, 40, 50][1...]
        let sliceChunks = slice.chunked(into: 3)
        #expect(sliceChunks.map { Array($0) } == [[20, 30, 40], [50]])
        #expect(sliceChunks.map(\.startIndex) == [1, 4])
    }

    @Test
    func splitsStringsByCharacter() {
        let chunks = "🇸🇾🇺🇸e\u{301}👍🏽abc".chunked(into: 2)
        #expect(chunks == ["🇸🇾🇺🇸", "é👍🏽", "ab", "c"])
    }

    @Test
    func worksWithNonRandomAccessCollections() {
        let chunks = Set([1]).chunked(into: 1)
        #expect(chunks.map { Array($0) } == [[1]])
        #expect("abcde".reversed().chunked(into: 2).map { String($0) } == ["ed", "cb", "a"])
    }
}
