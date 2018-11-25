//
//  NSPredicateExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 04.10.17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class NSPredicateExtensionsTests: XCTestCase {

    func testNot() {
        let predicate = NSPredicate(format: "a < 7")
        let notPredicate = predicate.not
        XCTAssert(notPredicate.compoundPredicateType == .not)
        if let subpredicates = notPredicate.subpredicates as? [NSPredicate] {
            XCTAssertEqual(subpredicates, [predicate])
        }
    }

    func testAndPredicate() {
        let predicate1 = NSPredicate(format: "a < 7")
        let predicate2 = NSPredicate(format: "a > 3")
        let andPredicate = predicate1.and(predicate2)
        XCTAssert(andPredicate.compoundPredicateType == .and)
        if let subpredicates = andPredicate.subpredicates as? [NSPredicate] {
            XCTAssertEqual(subpredicates, [predicate1, predicate2])
        }
    }

    func testOrPredicate() {
        let predicate1 = NSPredicate(format: "a < 7")
        let predicate2 = NSPredicate(format: "a > 3")
        let orPredicate = predicate1.or(predicate2)
        XCTAssert(orPredicate.compoundPredicateType == .or)
        if let subpredicates = orPredicate.subpredicates as? [NSPredicate] {
            XCTAssertEqual(subpredicates, [predicate1, predicate2])
        }
    }

    func testOperatorNot() {
        let predicate = NSPredicate(format: "a < 7")
        let notPredicate = !predicate
        XCTAssert(notPredicate.compoundPredicateType == .not)
        if let subpredicates = notPredicate.subpredicates as? [NSPredicate] {
            XCTAssertEqual(subpredicates, [predicate])
        }
    }

    func testOperatorAndPredicate() {
        let predicate1 = NSPredicate(format: "a < 7")
        let predicate2 = NSPredicate(format: "a > 3")
        let andPredicate = predicate1 + predicate2
        XCTAssert(andPredicate.compoundPredicateType == .and)
        if let subpredicates = andPredicate.subpredicates as? [NSPredicate] {
            XCTAssertEqual(subpredicates, [predicate1, predicate2])
        }
    }

    func testOperatorOrPredicate() {
        let predicate1 = NSPredicate(format: "a < 7")
        let predicate2 = NSPredicate(format: "a > 3")
        let orPredicate = predicate1 | predicate2
        XCTAssert(orPredicate.compoundPredicateType == .or)
        if let subpredicates = orPredicate.subpredicates as? [NSPredicate] {
            XCTAssertEqual(subpredicates, [predicate1, predicate2])
        }
    }

    func testOperatorSubPredicate() {
        let predicate1 = NSPredicate(format: "SELF BETWEEN{1,5}")
        let predicate2 = NSPredicate(format: "SELF BETWEEN{3,6}")
        let subPredicate = predicate1 - predicate2
        XCTAssert(subPredicate.evaluate(with: 2))
        XCTAssertFalse(subPredicate.evaluate(with: 4))
    }

}

#endif
