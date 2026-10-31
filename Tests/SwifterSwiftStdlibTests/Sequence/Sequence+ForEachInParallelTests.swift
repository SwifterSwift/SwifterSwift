// Sequence+ForEachInParallelTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceForEachInParallelTests {
    @Test
    func callsTheClosureOnceForEveryElement() async {
        let (stream, continuation) = AsyncStream.makeStream(of: Int.self)
        await (1...100).forEachInParallel { continuation.yield($0) }
        continuation.finish()

        var visited: [Int] = []
        for await value in stream {
            visited.append(value)
        }
        #expect(visited.sorted() == Array(1...100))
    }

    @Test
    func callsTheClosureForRepeatedElements() async {
        let (stream, continuation) = AsyncStream.makeStream(of: String.self)
        await ["a", "a", "👍🏽"].forEachInParallel { continuation.yield($0) }
        continuation.finish()

        var visited: [String] = []
        for await value in stream {
            visited.append(value)
        }
        #expect(visited.sorted() == ["a", "a", "👍🏽"])
    }

    @Test
    func returnsImmediatelyForEmptySequence() async {
        await [Int]().forEachInParallel { _ in
            Issue.record("The closure shouldn't be called for an empty sequence.")
        }
    }

    @Test(.timeLimit(.minutes(1)))
    func runsTheCallsConcurrently() async {
        // The first call waits for a signal that only the second call sends, so calling the closure for one element
        // at a time would never finish.
        let (signal, continuation) = AsyncStream.makeStream(of: Void.self)
        await [0, 1].forEachInParallel { element in
            if element == 0 {
                for await _ in signal {
                    break
                }
            } else {
                continuation.yield()
            }
        }
    }
}
