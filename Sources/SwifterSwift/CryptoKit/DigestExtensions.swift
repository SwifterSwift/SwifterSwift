// DigestExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(CryptoKit)
import CryptoKit

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public extension Digest {
    // MARK: - Properties

    /// SwifterSwift: Hexadecimal value string (read-only, Complexity: O(N), _N_ being the amount of bytes.)
    var hexString: String {
        var result = ""
        for byte in makeIterator() {
            result += String(format: "%02X", byte)
        }
        return result
    }
}
#endif
