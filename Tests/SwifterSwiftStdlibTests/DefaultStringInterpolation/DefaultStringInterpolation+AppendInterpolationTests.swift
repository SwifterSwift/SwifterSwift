// DefaultStringInterpolation+AppendInterpolationTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DefaultStringInterpolationAppendInterpolationTests {
    struct PredicateError: Error {}

    @Test
    func interpolatesValueThatPassesTheTest() {
        let count: Int? = 3
        #expect("Unread: \(count, default: "none", where: { $0 > 0 })" == "Unread: 3")
    }

    @Test
    func interpolatesDefaultForValueThatFailsTheTest() {
        let count: Int? = 0
        #expect("Unread: \(count, default: "none", where: { $0 > 0 })" == "Unread: none")
    }

    @Test
    func interpolatesDefaultForNil() {
        let count: Int? = nil
        #expect("Unread: \(count, default: "none", where: { $0 > 0 })" == "Unread: none")
    }

    @Test
    func interpolatesValuesLikeAPlainInterpolation() {
        let name: String? = "Swift"
        let ratio: Double? = 0.5
        let values: [Int]? = [1, 2]
        #expect("\(name, default: "-", where: { !$0.isEmpty })" == "Swift")
        #expect("\(ratio, default: "-", where: { $0.isFinite })" == "\(0.5)")
        #expect("\(values, default: "-", where: { !$0.isEmpty })" == "[1, 2]")
    }

    @Test
    func acceptsSubstringDefault() {
        let empty: String? = ""
        let fallback = "n/a, unknown".prefix(3)
        #expect("\(empty, default: fallback, where: { !$0.isEmpty })" == "n/a")
    }

    @Test
    func evaluatesDefaultOnlyWhenUsed() {
        var evaluations = 0
        func makeDefault() -> String {
            evaluations += 1
            return "-"
        }
        let present: Int? = 1
        let absent: Int? = nil
        #expect("\(present, default: makeDefault(), where: { _ in true })" == "1")
        #expect(evaluations == 0)
        #expect("\(absent, default: makeDefault(), where: { _ in true })" == "-")
        #expect(evaluations == 1)
    }

    @Test
    func doesNotCallTheTestForNil() {
        var calls = 0
        let absent: Int? = nil
        func countCall(_ value: Int) -> Bool {
            calls += 1
            return true
        }
        #expect("\(absent, default: "-", where: countCall)" == "-")
        #expect(calls == 0)
    }

    @Test
    func rethrowsErrorsFromTheTest() {
        let value: Int? = 1
        #expect(throws: PredicateError.self) {
            try "\(value, default: "-", where: { _ in throw PredicateError() })"
        }
    }

    @Test
    func keepsSurroundingLiteralText() {
        let first: Int? = -1
        let second: Int? = 2
        let text = "[\(first, default: "?", where: { $0 >= 0 })|\(second, default: "?", where: { $0 >= 0 })]"
        #expect(text == "[?|2]")
    }
}
