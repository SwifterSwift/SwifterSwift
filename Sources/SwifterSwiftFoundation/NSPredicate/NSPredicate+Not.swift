// NSPredicate+Not.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSPredicate {
    /// SwifterSwift: A compound predicate that is true when this predicate is false.
    ///
    /// It's a readable shorthand for `NSCompoundPredicate(notPredicateWithSubpredicate:)`, the form Core Data and
    /// CloudKit fetch requests need. For new code that doesn't need `NSPredicate`, the `#Predicate` macro can express
    /// the same condition with type checking.
    ///
    /// ```swift
    /// let isArchived = NSPredicate(format: "isArchived == YES")
    /// isArchived.not  // NOT isArchived == 1
    /// ```
    var not: NSCompoundPredicate {
        NSCompoundPredicate(notPredicateWithSubpredicate: self)
    }
}
#endif
