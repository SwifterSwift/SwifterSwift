// NSPredicate+And.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSPredicate {
    /// SwifterSwift: Returns a compound predicate that is true when both this predicate and the given one are true.
    ///
    /// It's a readable shorthand for `NSCompoundPredicate(andPredicateWithSubpredicates:)`, the form Core Data and
    /// CloudKit fetch requests need, and it chains: `a.and(b).and(c)`. For new code that doesn't need `NSPredicate`,
    /// the `#Predicate` macro can express the same condition with type checking.
    ///
    /// ```swift
    /// let isAdult = NSPredicate(format: "age >= 18")
    /// let isActive = NSPredicate(format: "isActive == YES")
    /// isAdult.and(isActive)  // age >= 18 AND isActive == 1
    /// ```
    ///
    /// - Parameter predicate: The predicate that must also be true.
    /// - Returns: An AND compound predicate whose subpredicates are this predicate and `predicate`, in that order.
    func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }
}
#endif
