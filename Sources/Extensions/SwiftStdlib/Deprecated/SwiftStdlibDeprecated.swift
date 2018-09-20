//
//  SwiftStdlibDeprecated.swift
//  SwifterSwift
//
//  Copyright © 2016 SwifterSwift
//

extension Bool {
    #if canImport(Foundation)
    /// SwifterSwift: Returns a random boolean value.
    ///
    ///     Bool.random -> true
    ///     Bool.random -> false
    ///
    @available(*, deprecated: 4.5.0, message: "Use random() instead")
    public static var random: Bool {
        return arc4random_uniform(2) == 1
    }
    #endif
}

extension String {

    #if canImport(Foundation)
    /// SwifterSwift: Check if string is valid email format.
    /// **Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.**.
    ///
    ///		"john@doe.com".isEmail -> true
    ///
    @available(*, deprecated: 4.5.0, message: "Use isValidEmail instead", renamed: "isValidEmail")
    public var isEmail: Bool {
        // http://emailregex.com/
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    #endif

}

public extension Array {

    /// SwifterSwift: Element at the given index if it exists.
    ///
    ///		[1, 2, 3, 4, 5].item(at: 2) -> 3
    ///		[1.2, 2.3, 4.5, 3.4, 4.5].item(at: 3) -> 3.4
    ///		["h", "e", "l", "l", "o"].item(at: 10) -> nil
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
    @available(*, deprecated: 4.3, message: "Use subscript(safe:) instead", renamed: "subscript(safe:)")
    public func item(at index: Int) -> Element? {
        guard startIndex..<endIndex ~= index else { return nil }
        return self[index]
    }

    /// SwifterSwift: Group the elements of the array in a dictionary.
    ///
    ///     [0, 2, 5, 4, 7].groupByKey { $0%2 ? "evens" : "odds" } -> [ "evens" : [0, 2, 4], "odds" : [5, 7] ]
    ///
    /// - Parameter getKey: Clousure to define the key for each element.
    /// - Returns: A dictionary with values grouped with keys.
    @available(*, deprecated: 4.3, message: "Use 'Dictionary.init(grouping:by:)' instead.")
    public func groupByKey<K: Hashable>(keyForValue: (_ element: Element) throws -> K) rethrows -> [K: [Element]] {
        var group = [K: [Element]]()
        for value in self {
            let key = try keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
        }
        return group
    }
}

public extension Array where Element: Equatable {

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].duplicatesRemoved() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    @available(*, deprecated: 4.3, message: "Use withoutDuplicates() instead", renamed: "withoutDuplicates")
    public func duplicatesRemoved() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    /// SwifterSwift: Remove last element from array and return it.
    ///
    ///		[1, 2, 3, 4, 5].pop() // returns 5 and remove it from the array.
    ///		[].pop() // returns nil since the array is empty.
    ///
    /// - Returns: last element in array (if applicable).
    @available(*, deprecated: 4.3, message: "Use popLast() instead")
    @discardableResult public mutating func pop() -> Element? {
        return popLast()
    }

    /// SwifterSwift: Insert an element to the end of array.
    ///
    ///		[1, 2, 3, 4].push(5) -> [1, 2, 3, 4, 5]
    ///		["h", "e", "l", "l"].push("o") -> ["h", "e", "l", "l", "o"]
    ///
    /// - Parameter newElement: element to insert.
    @available(*, deprecated: 4.3, message: "Use append() instead")
    public mutating func push(_ newElement: Element) {
        append(newElement)
    }

    /// SwifterSwift: Swap values at index positions.
    ///
    ///		[1, 2, 3, 4, 5].swap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    ///		["h", "e", "l", "l", "o"].swap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
    ///
    /// - Parameters:
    ///   - index: index of first element.
    ///   - otherIndex: index of other element.
    @available(*, deprecated: 4.3, message: "Use swapAt() instead")
    public mutating func swap(from index: Int, to otherIndex: Int) {
        swapAt(index, otherIndex)
    }

}

public extension Collection where Index == Int {

    #if canImport(Foundation)
    /// SwifterSwift: Random item from array.
    @available(*, deprecated: 4.5.0, message: "Use randomElement() instead")
    public var randomItem: Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    #endif
}

// MARK: - Methods
public extension FloatingPoint {

    #if canImport(Foundation)
    /// SwifterSwift: Random number between two number.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random number between two numbers.
    @available(*, deprecated: 4.5.0, message: "Double.random(in: ClosedRange<Float>)")
    public static func random(between min: Self, and max: Self) -> Self {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }
    #endif

    #if canImport(Foundation)
    /// SwifterSwift: Random number in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random number in the given closed range.
    @available(*, deprecated: 4.5.0, message: "Double.random(in: ClosedRange<Float>)")
    public static func random(inRange range: ClosedRange<Self>) -> Self {
        let delta = range.upperBound - range.lowerBound
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }
    #endif

}

// MARK: - Initializers
public extension FloatingPoint {

    /// SwifterSwift: Created a random number between two numbers.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    @available(*, deprecated: 4.5.0, message: "Double.random(in: ClosedRange<Float>)")
    public init(randomBetween min: Self, and max: Self) {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }

    /// SwifterSwift: Create a random number in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    @available(*, deprecated: 4.5.0, message: "Double.random(in: ClosedRange<Float>)")
    public init(randomInRange range: ClosedRange<Self>) {
        let delta = range.upperBound - range.lowerBound
        self = Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }

}

public extension Int {

    /// SwifterSwift: Random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random double between two double values.
    @available(*, deprecated: 4.5.0, message: "Int.random(in: ClosedRange<Float>)")
    public static func random(between min: Int, and max: Int) -> Int {
        return random(in: min...max)
    }

    /// SwifterSwift: Random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random double in the given closed range.
    @available(*, deprecated: 4.5.0, message: "Int.random(in: ClosedRange<Float>)")
    public static func random(inRange range: ClosedRange<Int>) -> Int {
        return random(in: range)
    }

    /// SwifterSwift: Created a random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    @available(*, deprecated: 4.5.0, message: "Int.random(in: ClosedRange<Float>)")
    public init(randomBetween min: Int, and max: Int) {
        self = Int.random(in: min...max)
    }

    /// SwifterSwift: Create a random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    @available(*, deprecated: 4.5.0, message: "Int.random(in: ClosedRange<Float>)")
    public init(randomInRange range: ClosedRange<Int>) {
        self = Int.random(in: range)
    }
}
