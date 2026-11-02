// NSPredicate+Or.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSPredicate {
    /// SwifterSwift: Returns a compound predicate that is true when this predicate, the given one, or both are true.
    ///
    /// It's a readable shorthand for `NSCompoundPredicate(orPredicateWithSubpredicates:)`, the form Core Data and
    /// CloudKit fetch requests need, and it chains: `a.or(b).or(c)`. For new code that doesn't need `NSPredicate`,
    /// the `#Predicate` macro can express the same condition with type checking.
    ///
    /// ```swift
    /// let isAdmin = NSPredicate(format: "role == 'admin'")
    /// let isOwner = NSPredicate(format: "isOwner == YES")
    /// isAdmin.or(isOwner)  // role == "admin" OR isOwner == 1
    /// ```
    ///
    /// - Parameter predicate: The predicate that may be true instead.
    /// - Returns: An OR compound predicate whose subpredicates are this predicate and `predicate`, in that order.
    func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }
}
#endif
