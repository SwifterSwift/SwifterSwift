// DigestExtensions.swift - Copyright 2022 SwifterSwift

#if canImport(CryptoKit)
import CryptoKit

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
public extension Digest {

    // MARK: - Properties

    /// SwifterSwift: Hexadecimal value string (read-only)
    var hexString: String {
        let bytes: [UInt8] = Array(makeIterator())
        return Data(bytes).map { String(format: "%02X", $0) }.joined()
    }
}
#endif
