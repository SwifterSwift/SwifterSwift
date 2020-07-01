//
//  RawRepresentableExtensions.swift
//  SwifterSwift
//
//  Created by 方林威 on 2020/7/1.
//  Copyright © 2020 SwifterSwift
//

// MARK: - Initializers
public extension RawRepresentable {
    
    /// SwifterSwift: Initializes an  enumeration type. If `rawValue` was malformed, returns `nil`.
    /// - Parameters:
    ///   - rawValue: Initialize the value of the enum type..
    init?(rawValue: RawValue?) {
        guard let value = rawValue else {
            return nil
        }
        self.init(rawValue: value)
    }
}
