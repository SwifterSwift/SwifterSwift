// Optional+IsNilOrEmpty.swift - Copyright 2026 SwifterSwift

public extension Optional where Wrapped: Collection {
    /// SwifterSwift: A Boolean value indicating whether the optional is `nil` or wraps an empty collection.
    ///
    /// The common shortcut `value?.isEmpty == true` is `false` for `nil`, which is rarely what's meant; this property
    /// treats `nil` as empty. A string of spaces isn't empty.
    ///
    /// ```swift
    /// let missing: String? = nil
    /// missing.isNilOrEmpty  // true
    ///
    /// let empty: [Int]? = []
    /// empty.isNilOrEmpty  // true
    ///
    /// let name: String? = "Swift"
    /// name.isNilOrEmpty  // false
    /// ```
    ///
    /// - Complexity: O(1) for collections whose `isEmpty` is O(1), which includes all standard library collections.
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
