// SetExtensions.swift - Copyright 2024 SwifterSwift

public extension Set {
    
    /// SwifterSwift: Toggles an element in the set. If the element is present, it removes it; otherwise, it inserts it.
    ///
    ///     var set: Set<T> = [T1, T2, T3]
    ///     set.toggle(T1) -> [T2, T3]
    ///     set.toggle(T4) -> [T2, T3, T4]
    ///     set.toggle(T1) -> [T1, T2, T3, T4]
    ///
    /// - Parameter element: The element to toggle in or out of the set.
    mutating func toggle(_ element: Element) {
        if contains(element) {
            self.remove(element)
        } else {
            self.insert(element)
        }
    }
}
