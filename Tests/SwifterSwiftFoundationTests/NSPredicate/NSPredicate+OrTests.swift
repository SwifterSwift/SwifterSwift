// NSPredicate+OrTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSPredicateOrTests {
    @Test
    func combinesBothPredicatesInOrder() {
        let first = NSPredicate(value: true)
        let second = NSPredicate(value: false)
        let combined = first.or(second)
        let subpredicates: [Any] = combined.subpredicates
        #expect(combined.compoundPredicateType == .or)
        #expect(subpredicates.count == 2)
        #expect(subpredicates.first as? NSPredicate === first)
        #expect(subpredicates.last as? NSPredicate === second)
    }

    @Test(arguments: [(true, true, true), (true, false, true), (false, true, true), (false, false, false)])
    func followsTheTruthTableOfOr(lhs: Bool, rhs: Bool, expected: Bool) {
        #expect(NSPredicate(value: lhs).or(NSPredicate(value: rhs)).evaluate(with: nil) == expected)
    }

    @Test
    func chains() {
        let chained = NSPredicate(value: false).or(NSPredicate(value: false)).or(NSPredicate(value: true))
        #expect(chained.compoundPredicateType == .or)
        #expect(chained.evaluate(with: nil))
    }

    #if canImport(Darwin)
    @Test
    func describesTheCombinedFormat() {
        let isAdmin = NSPredicate(format: "role == 'admin'")
        let isOwner = NSPredicate(format: "isOwner == YES")
        let combined = isAdmin.or(isOwner)
        #expect(combined.predicateFormat == #"role == "admin" OR isOwner == 1"#)
        #expect(combined.evaluate(with: ["role": "admin", "isOwner": false]))
        #expect(combined.evaluate(with: ["role": "guest", "isOwner": true]))
        #expect(!combined.evaluate(with: ["role": "guest", "isOwner": false]))
    }
    #endif
}
#endif
