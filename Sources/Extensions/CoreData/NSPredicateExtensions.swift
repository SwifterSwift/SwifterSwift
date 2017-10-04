//
//  NSPredicateExtensions.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 04.10.17.
//

import CoreData
import Foundation

// MARK: - Methods
public extension NSPredicate {
    
    /// SwifterSwift: Returns a new predicate formed by AND-ing the argument to the predicate.
    public func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }
    
    /// SwifterSwift: Returns a new predicate formed by OR-ing the argument to the predicate.
    public func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }
    
}
