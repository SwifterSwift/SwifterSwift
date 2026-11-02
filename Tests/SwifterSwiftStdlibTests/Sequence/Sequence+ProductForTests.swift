// Sequence+ProductForTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceProductForTests {
    @Test
    func returnsTheProductOfTheValues() {
        #expect(["Ana", "Ben", "Cyril"].product(for: \.count) == 45)
        #expect([1, 2, 3].product(for: { $0 * 2 }) == 48)
        #expect([1, 2].product(for: { Double($0) / 4 }) == 0.125)
    }

    @Test
    func returnsOneForEmptySequence() {
        #expect([String]().product(for: \.count) == 1)
        #expect([Int]().product(for: { Double($0) }) == 1)
    }

    @Test
    func handlesNegativeAndZeroValues() {
        #expect([1, 2, 3].product(for: { $0 - 4 }) == -6)
        #expect([1, 2, 3].product(for: { $0 - 2 }) == 0)
    }

    @Test
    func rethrowsErrorsFromTheClosure() {
        #expect(throws: CancellationError.self) {
            try [1].product(for: { (_: Int) throws -> Int in throw CancellationError() })
        }
    }
}
