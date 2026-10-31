// RangeReplaceableCollection+KeepTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionKeepTests {
    @Test(arguments: [
        ([2, 4, 5, 6, 8], [2, 4]),
        ([2, 4, 6], [2, 4, 6]),
        ([1, 2, 4], []),
        ([], [])
    ])
    func keepsTheLeadingMatches(_ numbers: [Int], expected: [Int]) {
        var numbers = numbers
        numbers.keep(while: { $0.isMultiple(of: 2) })
        #expect(numbers == expected)
    }

    @Test
    func stopsCallingThePredicateAfterTheFirstFailure() {
        var numbers = [2, 3, 4, 6]
        var calls = 0
        numbers.keep { number in
            calls += 1
            return number.isMultiple(of: 2)
        }
        #expect(numbers == [2])
        #expect(calls == 2)
    }

    @Test
    func keepsLeadingCharactersOfStrings() {
        var text = "héllo👍🏽 world"
        text.keep(while: { $0 != " " })
        #expect(text == "héllo👍🏽")

        var digits = "123abc"
        digits.keep(while: \.isNumber)
        #expect(digits == "123")
    }

    @Test
    func rethrowsAndLeavesTheCollectionUnchanged() {
        var numbers = [1, 2, 3]
        #expect(throws: CancellationError.self) {
            try numbers.keep(while: { _ in throw CancellationError() })
        }
        #expect(numbers == [1, 2, 3])
    }
}
