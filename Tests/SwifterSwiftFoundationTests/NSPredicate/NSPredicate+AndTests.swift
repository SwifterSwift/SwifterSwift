// NSPredicate+AndTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSPredicateAndTests {
    @Test
    func combinesBothPredicatesInOrder() {
        let first = NSPredicate(value: true)
        let second = NSPredicate(value: false)
        let combined = first.and(second)
        let subpredicates: [Any] = combined.subpredicates
        #expect(combined.compoundPredicateType == .and)
        #expect(subpredicates.count == 2)
        #expect(subpredicates.first as? NSPredicate === first)
        #expect(subpredicates.last as? NSPredicate === second)
    }

    @Test(arguments: [(true, true, true), (true, false, false), (false, true, false), (false, false, false)])
    func followsTheTruthTableOfAnd(lhs: Bool, rhs: Bool, expected: Bool) {
        #expect(NSPredicate(value: lhs).and(NSPredicate(value: rhs)).evaluate(with: nil) == expected)
    }

    @Test
    func chains() {
        let chained = NSPredicate(value: true).and(NSPredicate(value: true)).and(NSPredicate(value: false))
        #expect(chained.compoundPredicateType == .and)
        #expect(!chained.evaluate(with: nil))
    }

    #if canImport(Darwin)
    @Test
    func describesTheCombinedFormat() {
        let isAdult = NSPredicate(format: "age >= 18")
        let isActive = NSPredicate(format: "isActive == YES")
        let combined = isAdult.and(isActive)
        #expect(combined.predicateFormat == "age >= 18 AND isActive == 1")
        #expect(combined.evaluate(with: ["age": 30, "isActive": true]))
        #expect(!combined.evaluate(with: ["age": 30, "isActive": false]))
        #expect(!combined.evaluate(with: ["age": 12, "isActive": true]))
    }
    #endif
}
#endif
