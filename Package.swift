// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ConciseMagicFile"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("ForwardTrailingClosures")
]

let package = Package(
    name: "SwifterSwift",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "SwifterSwift", targets: [
            "SwifterSwift-AppKit",
            "SwifterSwift-Combine",
            "SwifterSwift-CoreAnimation",
            "SwifterSwift-CoreGraphics",
            "SwifterSwift-CoreLocation",
            "SwifterSwift-CryptoKit",
            "SwifterSwift-Dispatch",
            "SwifterSwift-Foundation",
            "SwifterSwift-HealthKit",
            "SwifterSwift-MapKit",
            "SwifterSwift-SceneKit",
            "SwifterSwift-SpriteKit",
            "SwifterSwift-StoreKit",
            "SwifterSwift-SwiftStdlib",
            "SwifterSwift-UIKit",
            "SwifterSwift-WebKit"
        ]),
        .library(name: "SwifterSwift-AppKit", targets: ["SwifterSwift-AppKit"]),
        .library(name: "SwifterSwift-Combine", targets: ["SwifterSwift-Combine"]),
        .library(name: "SwifterSwift-CoreAnimation", targets: ["SwifterSwift-CoreAnimation"]),
        .library(name: "SwifterSwift-CoreGraphics", targets: ["SwifterSwift-CoreGraphics"]),
        .library(name: "SwifterSwift-CoreLocation", targets: ["SwifterSwift-CoreLocation"]),
        .library(name: "SwifterSwift-CryptoKit", targets: ["SwifterSwift-CryptoKit"]),
        .library(name: "SwifterSwift-Dispatch", targets: ["SwifterSwift-Dispatch"]),
        .library(name: "SwifterSwift-Foundation", targets: ["SwifterSwift-Foundation"]),
        .library(name: "SwifterSwift-HealthKit", targets: ["SwifterSwift-HealthKit"]),
        .library(name: "SwifterSwift-MapKit", targets: ["SwifterSwift-MapKit"]),
        .library(name: "SwifterSwift-SceneKit", targets: ["SwifterSwift-SceneKit"]),
        .library(name: "SwifterSwift-SpriteKit", targets: ["SwifterSwift-SpriteKit"]),
        .library(name: "SwifterSwift-StoreKit", targets: ["SwifterSwift-StoreKit"]),
        .library(name: "SwifterSwift-SwiftStdlib", targets: ["SwifterSwift-SwiftStdlib"]),
        .library(name: "SwifterSwift-UIKit", targets: ["SwifterSwift-UIKit"]),
        .library(name: "SwifterSwift-WebKit", targets: ["SwifterSwift-WebKit"])
    ],
    targets: [
        .target(
            name: "SwifterSwift-AppKit",
            path: "Sources/SwifterSwift/AppKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-Combine",
            path: "Sources/SwifterSwift/Combine",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-CoreAnimation",
            dependencies: ["SwifterSwift-Shared"],
            path: "Sources/SwifterSwift/CoreAnimation",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-CoreGraphics",
            path: "Sources/SwifterSwift/CoreGraphics",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-CoreLocation",
            path: "Sources/SwifterSwift/CoreLocation",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-CryptoKit",
            path: "Sources/SwifterSwift/CryptoKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-Dispatch",
            path: "Sources/SwifterSwift/Dispatch",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-Foundation",
            dependencies: ["SwifterSwift-Shared"],
            path: "Sources/SwifterSwift/Foundation",
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ],
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-HealthKit",
            path: "Sources/SwifterSwift/HealthKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-MapKit",
            dependencies: ["SwifterSwift-Shared"],
            path: "Sources/SwifterSwift/MapKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-SceneKit",
            dependencies: ["SwifterSwift-Shared"],
            path: "Sources/SwifterSwift/SceneKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-Shared",
            path: "Sources/SwifterSwift/Shared",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-SpriteKit",
            path: "Sources/SwifterSwift/SpriteKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-StoreKit",
            path: "Sources/SwifterSwift/StoreKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-SwiftStdlib",
            dependencies: ["SwifterSwift-Shared"],
            path: "Sources/SwifterSwift/SwiftStdlib",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-UIKit",
            path: "Sources/SwifterSwift/UIKit",
            swiftSettings: swiftSettings),
        .target(
            name: "SwifterSwift-WebKit",
            path: "Sources/SwifterSwift/WebKit",
            swiftSettings: swiftSettings),
        .testTarget(
            name: "SwifterSwiftTests",
            dependencies: [
                "SwifterSwift-AppKit",
                "SwifterSwift-Combine",
                "SwifterSwift-CoreAnimation",
                "SwifterSwift-CoreGraphics",
                "SwifterSwift-CoreLocation",
                "SwifterSwift-CryptoKit",
                "SwifterSwift-Dispatch",
                "SwifterSwift-Foundation",
                "SwifterSwift-HealthKit",
                "SwifterSwift-MapKit",
                "SwifterSwift-SceneKit",
                "SwifterSwift-SpriteKit",
                "SwifterSwift-StoreKit",
                "SwifterSwift-SwiftStdlib",
                "SwifterSwift-UIKit",
                "SwifterSwift-WebKit"
            ],
            path: "Tests",
            exclude: ["Info.plist"],
            resources: [.process("ResourcesTests/Resources")],
            swiftSettings: swiftSettings)
    ])
