// NSPredicate+NotTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSPredicateNotTests {
    @Test
    func wrapsThePredicateInANotCompound() {
        let predicate = NSPredicate(value: true)
        let negated = predicate.not
        let subpredicates: [Any] = negated.subpredicates
        #expect(negated.compoundPredicateType == .not)
        #expect(subpredicates.count == 1)
        #expect(subpredicates.first as? NSPredicate === predicate)
    }

    @Test(arguments: [true, false])
    func evaluatesToTheOppositeValue(value: Bool) {
        #expect(NSPredicate(value: value).not.evaluate(with: nil) == !value)
    }

    @Test(arguments: [true, false])
    func cancelsOutWhenAppliedTwice(value: Bool) {
        #expect(NSPredicate(value: value).not.not.evaluate(with: nil) == value)
    }

    #if canImport(Darwin)
    @Test
    func describesTheNegatedFormat() {
        let isArchived = NSPredicate(format: "isArchived == YES")
        #expect(isArchived.not.predicateFormat == "NOT isArchived == 1")
        #expect(isArchived.not.evaluate(with: ["isArchived": false]))
        #expect(!isArchived.not.evaluate(with: ["isArchived": true]))
    }
    #endif
}
#endif
