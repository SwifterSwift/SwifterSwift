//
//  NSMutableAttributedStringExtensions.swift
//  SwifterSwift
//
//  Created by ratul sharker on 12/12/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Foundation)
import Foundation

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Methods
public extension NSMutableAttributedString {

    #if os(iOS)
    /// SwifterSwift: Applies given color to the substring found in the attributed string, in round robin fashion.
    ///
    /// - Parameters:
    ///   - colors: colors meant to applied to the substring.
    ///   - substring: string on which the colors would be applied.
    public func applying(colors: [UIColor], substring: String) {

        guard !colors.isEmpty,
            let range = string.range(of: substring) else { return }

        let nsRange = NSRange(range, in: string)

        for indices in 0..<nsRange.length {
            let subRange = NSRange(location: indices + nsRange.location, length: 1)
            addAttributes([.foregroundColor: colors[indices%colors.count]], range: subRange)
        }
    }
    #endif
}
#endif
