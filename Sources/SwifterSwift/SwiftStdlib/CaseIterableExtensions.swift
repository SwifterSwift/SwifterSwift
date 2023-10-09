// CaseIterableExtensions.swift - Copyright 2023 SwifterSwift

import Foundation

public extension CaseIterable where Self: Equatable, AllCases == [Self] {
    
    /// SwifterSwift: Sets the value to next available case from given array.
    ///
    ///     enum ShuffleMode: CaseIterable {
    ///        case off, songs, albums
    ///     }
    ///
    ///     var mode: ShuffleMode = .off
    ///     mode.toggle() // .songs
    ///
    ///     var mode: ShuffleMode = .albums
    ///     mode.toggle() // .off
    ///
    ///     var mode: ShuffleMode = .albums
    ///     mode.toggle(cycle: false) // .albums
    ///
    ///     var mode: ShuffleMode = .albums
    ///     mode.toggle(between: [.songs, .albums]) // .songs
    ///
    /// - Parameters:
    ///    - cases: Array of values that can be assigned to the caller.
    ///    If empty array is passed the possible values will be taken from `allCases` array.
    ///    - cycle: Indicates whether the value should be modified if it's already at the end of `values` array.
    ///
    mutating func toggle(
        between values: [Self] = Self.allCases,
        cycle: Bool = false
    ) {
        guard var index = values.firstIndex(of: self) else {
            fatalError("Case \(self) must be included in `values` array.")
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
