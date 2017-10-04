//
//  NSFetchRequestExtensions.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 04.10.17.
//

import CoreData
import Foundation

// MARK: - Methods
public extension NSFetchRequest {
    
    /// SwifterSwift: Returns the fetch request with the given predicate.
    @objc public func withPredicate(_ predicate: NSPredicate) -> NSFetchRequest {
        self.predicate = predicate
        return self
    }
}
