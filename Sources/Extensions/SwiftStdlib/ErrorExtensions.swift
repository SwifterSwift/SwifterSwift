//
//  ErrorExtensions.swift
//  SwifterSwift
//
//  Created by Stas Rybakov on 01/03/2019.
//  Copyright © 2019 SwifterSwift
//

import Foundation

// MARK: - Methods
extension Error {
  
  /// Compare errors
  ///
  /// - Parameter another: Error for compare
  /// - Returns: True if errors are equal
  func isThatError(another: Error) -> Bool {
    return (self as NSError) == (another as NSError)
  }
}
