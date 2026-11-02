// Sequence+ContainsDuplicatesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceContainsDuplicatesTests {
    @Test(arguments: [[1, 2, 3, 2], [1, 1], [Int.min, 0, Int.min]])
    func returnsTrueWhenAnElementRepeats(_ numbers: [Int]) {
        #expect(numbers.containsDuplicates())
    }

    @Test(arguments: [[1, 2, 3], [42], [Int.min, Int.max], []])
    func returnsFalseWhenEveryElementIsUnique(_ numbers: [Int]) {
        #expect(!numbers.containsDuplicates())
    }

    @Test
    func comparesCharacters() {
        #expect(!"swift".containsDuplicates())
        #expect("hello".containsDuplicates())
        // The precomposed "é" and "e" with a combining accent are the same `Character`.
        #expect("\u{E9}e\u{301}".containsDuplicates())
        #expect(!"👍🏽👍".containsDuplicates())
        #expect("🇸🇾🇸🇾".containsDuplicates())
    }

    @Test
    func stopsAtTheFirstRepeatedElement() {
        let cycle = sequence(first: 0) { ($0 + 1) % 3 }
        #expect(cycle.containsDuplicates())
    }

    @Test
    func worksWithSinglePassSequences() {
        var iterator = [1, 2, 1].makeIterator()
        #expect(AnyIterator { iterator.next() }.containsDuplicates())
    }
}
