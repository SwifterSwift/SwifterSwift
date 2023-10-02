// StringDeprecated.swift - Copyright 2023 SwifterSwift

extension String {
    /// SwifterSwift: Create a new random string of given length.
    ///
    ///        String(randomOfLength: 10) -> "gY8r3MHvlQ"
    ///
    /// - Parameter length: number of characters in string.
    @available(*, deprecated, message: "Use String.random(ofLength:) instead.")
    init(randomOfLength length: Int) {
        guard length > 0 else {
            self.init()
            return
        }

        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        self = randomString
    }
}
