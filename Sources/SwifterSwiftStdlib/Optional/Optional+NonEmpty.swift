// Optional+NonEmpty.swift - Copyright 2026 SwifterSwift

public extension Optional where Wrapped: Collection {
    /// SwifterSwift: The wrapped collection, or `nil` if the optional is `nil` or the collection is empty.
    ///
    /// Turning an empty collection into `nil` lets `??`, `if let` and optional chaining treat "empty" and "missing"
    /// the same way. A string of spaces isn't empty, so it's returned as is.
    ///
    /// ```swift
    /// let nickname: String? = ""
    /// nickname.nonEmpty ?? "Anonymous"  // "Anonymous"
    ///
    /// let tags: [String]? = ["swift"]
    /// tags.nonEmpty  // ["swift"]
    ///
    /// let missing: [String]? = nil
    /// missing.nonEmpty  // nil
    /// ```
    ///
    /// - Complexity: O(1) for collections whose `isEmpty` is O(1), which includes all standard library collections.
    var nonEmpty: Wrapped? {
        guard let collection = self, !collection.isEmpty else { return nil }
        return collection
    }
}
