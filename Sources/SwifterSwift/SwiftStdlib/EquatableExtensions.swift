// EquatableExtensions.swift - Copyright 2023 SwifterSwift

import Foundation

public extension Equatable {
    
    /// SwifterSwift: Sets the value to next available value from given array.
    ///
    ///     enum ShuffleMode {
    ///        case off, songs, albums
    ///     }
    ///
    ///     let values: [ShuffleMode] = [.off, .songs, .albums]
    ///
    ///     var mode: ShuffleMode = .off
    ///     mode.toggle(between: values) // .songs
    ///
    ///     var mode: ShuffleMode = .albums
    ///     mode.toggle(between: values) // .off
    ///
    ///     var mode: ShuffleMode = .albums
    ///     mode.toggle(between: values, cycle: false) // .albums
    ///
    ///     var mode: ShuffleMode = .albums
    ///     mode.toggle(between: [.songs, .albums]) // .songs
    ///
    /// - Parameters:
    ///    - cases: Array of values that can be assigned to the caller.
    ///    - cycle: Indicates whether the value should be modified if it's already at the end of `values` array.
    ///
    mutating func toggle(
        between values: [Self],
        cycle: Bool = false
    ) {
        guard var index = values.firstIndex(of: self) else {
            fatalError("Value \(self) must be included in `values` array.")
        }
        if index < (values.count - 1) {
            index += 1
        }
        else {
            if !cycle { return }
            index = 0
        }
        self = values[index]
    }
    
}
