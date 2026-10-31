// Collection+Average.swift - Copyright 2026 SwifterSwift

public extension Collection where Element: BinaryInteger {
    /// SwifterSwift: Returns the arithmetic mean of the elements, or `nil` if the collection is empty.
    ///
    /// The elements are added up as `Double` values, so the sum can't overflow, even for values near `Int.max` or
    /// `Int.min`. A `Double` holds integers exactly only up to 2^53, so for larger values the result is the nearest
    /// `Double` rather than the exact mean.
    ///
    /// ```swift
    /// [1, 2, 3, 4].average()  // 2.5
    /// [-4, 4].average()  // 0.0
    /// [Int.max, Int.max].average()  // 9.223372036854776e+18
    /// [Int]().average()  // nil
    /// ```
    ///
    /// - Returns: The mean of the elements as a `Double`, or `nil` if the collection is empty.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    func average() -> Double? {
        var sum = 0.0
        var count = 0
        for element in self {
            sum += Double(element)
            count += 1
        }
        guard count > 0 else { return nil }
        return sum / Double(count)
    }
}

public extension Collection where Element: FloatingPoint {
    /// SwifterSwift: Returns the arithmetic mean of the elements, or `nil` if the collection is empty.
    ///
    /// The mean of finite elements always lies between the smallest and the largest element, even where rounding
    /// would push it slightly outside, so the mean of `[0.1, 0.1, 0.1]` is exactly `0.1`. When the sum of finite
    /// elements overflows, the mean is computed again from the elements divided by the count, so the mean of
    /// `[.greatestFiniteMagnitude, .greatestFiniteMagnitude]` is `.greatestFiniteMagnitude` instead of infinity.
    ///
    /// A NaN element makes the result NaN, and infinite elements follow the usual floating-point rules, so the mean of
    /// `[.infinity, 1]` is infinity and the mean of `[.infinity, -.infinity]` is NaN.
    ///
    /// ```swift
    /// [1.5, 2.5, 3.5].average()  // 2.5
    /// [-1.0, 1.0].average()  // 0.0
    /// [Double.greatestFiniteMagnitude, .greatestFiniteMagnitude].average()  // 1.7976931348623157e+308
    /// [Double]().average()  // nil
    /// ```
    ///
    /// - Returns: The mean of the elements, or `nil` if the collection is empty.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    func average() -> Element? {
        var sum: Element = .zero
        var count = 0
        var lowest: Element = .infinity
        var highest: Element = -.infinity
        var isAllFinite = true
        for element in self {
            sum += element
            count += 1
            isAllFinite = isAllFinite && element.isFinite
            if element < lowest {
                lowest = element
            }
            if element > highest {
                highest = element
            }
        }
        guard count > 0 else { return nil }
        let divisor = Element(count)
        guard isAllFinite else { return sum / divisor }
        let mean = sum.isFinite ? sum / divisor : reduce(.zero) { $0 + $1 / divisor }
        if mean < lowest {
            return lowest
        }
        if mean > highest {
            return highest
        }
        return mean
    }
}
