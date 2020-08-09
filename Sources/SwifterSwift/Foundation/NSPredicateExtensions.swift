// NSPredicateExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(Foundation)
import Foundation

// MARK: - Properties

public extension NSPredicate {
    /// SwifterSwift: Returns a new predicate formed by NOT-ing the predicate.
    var not: NSCompoundPredicate {
        NSCompoundPredicate(notPredicateWithSubpredicate: self)
    }
}

// MARK: - Methods

public extension NSPredicate {
    /// SwifterSwift: Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate
    /// - Returns: NSCompoundPredicate
    func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }

    /// SwifterSwift: Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate
    /// - Returns: NSCompoundPredicate
    func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }
}

// MARK: - Operators

public extension NSPredicate {
    /// SwifterSwift: Returns a new predicate formed by NOT-ing the predicate.
    /// - Parameters: rhs: NSPredicate to convert.
    /// - Returns: NSCompoundPredicate
    static prefix func ! (rhs: NSPredicate) -> NSCompoundPredicate {
        rhs.not
    }

    /// SwifterSwift: Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static func + (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        lhs.and(rhs)
    }

    /// SwifterSwift: Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static func | (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        lhs.or(rhs)
    }

    /// SwifterSwift: Returns a new predicate formed by remove the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static func - (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        lhs + !rhs
    }
}

#endif
