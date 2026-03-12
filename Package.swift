// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwifterSwift",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "SwifterSwift", targets: ["SwifterSwift"]),
        .library(name: "SwifterSwiftNoIBInspectable", targets: ["SwifterSwiftNoIBInspectable"]),
        .library(name: "SwifterSwiftShared", targets: ["SwifterSwiftShared"]),
        .library(name: "SwifterSwiftSwiftStdlib", targets: ["SwifterSwiftSwiftStdlib"]),
        .library(name: "SwifterSwiftFoundation", targets: ["SwifterSwiftFoundation"]),
        .library(name: "SwifterSwiftUIKit", targets: ["SwifterSwiftUIKit"]),
        .library(name: "SwifterSwiftUIKitNoIBInspectable", targets: ["SwifterSwiftUIKitNoIBInspectable"]),
        .library(name: "SwifterSwiftAppKit", targets: ["SwifterSwiftAppKit"]),
        .library(name: "SwifterSwiftAppKitNoIBInspectable", targets: ["SwifterSwiftAppKitNoIBInspectable"]),
        .library(name: "SwifterSwiftCoreAnimation", targets: ["SwifterSwiftCoreAnimation"]),
        .library(name: "SwifterSwiftCoreGraphics", targets: ["SwifterSwiftCoreGraphics"]),
        .library(name: "SwifterSwiftCoreLocation", targets: ["SwifterSwiftCoreLocation"]),
        .library(name: "SwifterSwiftCryptoKit", targets: ["SwifterSwiftCryptoKit"]),
        .library(name: "SwifterSwiftDispatch", targets: ["SwifterSwiftDispatch"]),
        .library(name: "SwifterSwiftHealthKit", targets: ["SwifterSwiftHealthKit"]),
        .library(name: "SwifterSwiftMapKit", targets: ["SwifterSwiftMapKit"]),
        .library(name: "SwifterSwiftSceneKit", targets: ["SwifterSwiftSceneKit"]),
        .library(name: "SwifterSwiftSpriteKit", targets: ["SwifterSwiftSpriteKit"]),
        .library(name: "SwifterSwiftStoreKit", targets: ["SwifterSwiftStoreKit"]),
        .library(name: "SwifterSwiftWebKit", targets: ["SwifterSwiftWebKit"])
    ],
    targets: [
        .target(
            name: "SwifterSwift",
            dependencies: [
                "SwifterSwiftShared",
                "SwifterSwiftSwiftStdlib",
                "SwifterSwiftFoundation",
                "SwifterSwiftUIKit",
                "SwifterSwiftAppKit",
                "SwifterSwiftCoreAnimation",
                "SwifterSwiftCoreGraphics",
                "SwifterSwiftCoreLocation",
                "SwifterSwiftCryptoKit",
                "SwifterSwiftDispatch",
                "SwifterSwiftHealthKit",
                "SwifterSwiftMapKit",
                "SwifterSwiftSceneKit",
                "SwifterSwiftSpriteKit",
                "SwifterSwiftStoreKit",
                "SwifterSwiftWebKit"
            ],
            path: "Sources/SwifterSwift"),
        .target(
            name: "SwifterSwiftNoIBInspectable",
            dependencies: [
                "SwifterSwiftShared",
                "SwifterSwiftSwiftStdlib",
                "SwifterSwiftFoundation",
                "SwifterSwiftUIKitNoIBInspectable",
                "SwifterSwiftAppKitNoIBInspectable",
                "SwifterSwiftCoreAnimation",
                "SwifterSwiftCoreGraphics",
                "SwifterSwiftCoreLocation",
                "SwifterSwiftCryptoKit",
                "SwifterSwiftDispatch",
                "SwifterSwiftHealthKit",
                "SwifterSwiftMapKit",
                "SwifterSwiftSceneKit",
                "SwifterSwiftSpriteKit",
                "SwifterSwiftStoreKit",
                "SwifterSwiftWebKit"
            ],
            path: "Sources/SwifterSwiftNoIBInspectable"),
        .target(
            name: "SwifterSwiftShared",
            path: "Sources/SwifterSwiftShared"),
        .target(
            name: "SwifterSwiftSwiftStdlib",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftSwiftStdlib"),
        .target(
            name: "SwifterSwiftFoundation",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftFoundation",
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]),
        .target(
            name: "SwifterSwiftCoreAnimation",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftCoreAnimation"),
        .target(
            name: "SwifterSwiftCoreGraphics",
            path: "Sources/SwifterSwiftCoreGraphics"),
        .target(
            name: "SwifterSwiftCoreLocation",
            path: "Sources/SwifterSwiftCoreLocation"),
        .target(
            name: "SwifterSwiftCryptoKit",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftCryptoKit"),
        .target(
            name: "SwifterSwiftDispatch",
            path: "Sources/SwifterSwiftDispatch"),
        .target(
            name: "SwifterSwiftHealthKit",
            path: "Sources/SwifterSwiftHealthKit"),
        .target(
            name: "SwifterSwiftMapKit",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftMapKit"),
        .target(
            name: "SwifterSwiftSceneKit",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftSceneKit"),
        .target(
            name: "SwifterSwiftSpriteKit",
            path: "Sources/SwifterSwiftSpriteKit"),
        .target(
            name: "SwifterSwiftStoreKit",
            path: "Sources/SwifterSwiftStoreKit"),
        .target(
            name: "SwifterSwiftWebKit",
            path: "Sources/SwifterSwiftWebKit"),
        .target(
            name: "SwifterSwiftUIKit",
            dependencies: ["SwifterSwiftUIKitCore", "SwifterSwiftUIKitIBInspectable"],
            path: "Sources/SwifterSwiftUIKit"),
        .target(
            name: "SwifterSwiftUIKitNoIBInspectable",
            dependencies: ["SwifterSwiftUIKitCore"],
            path: "Sources/SwifterSwiftUIKitNoIBInspectable"),
        .target(
            name: "SwifterSwiftUIKitCore",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftUIKitCore"),
        .target(
            name: "SwifterSwiftUIKitIBInspectable",
            dependencies: ["SwifterSwiftUIKitCore"],
            path: "Sources/SwifterSwiftUIKitIBInspectable"),
        .target(
            name: "SwifterSwiftAppKit",
            dependencies: ["SwifterSwiftAppKitCore", "SwifterSwiftAppKitIBInspectable"],
            path: "Sources/SwifterSwiftAppKit"),
        .target(
            name: "SwifterSwiftAppKitNoIBInspectable",
            dependencies: ["SwifterSwiftAppKitCore"],
            path: "Sources/SwifterSwiftAppKitNoIBInspectable"),
        .target(
            name: "SwifterSwiftAppKitCore",
            dependencies: ["SwifterSwiftShared"],
            path: "Sources/SwifterSwiftAppKitCore"),
        .target(
            name: "SwifterSwiftAppKitIBInspectable",
            dependencies: ["SwifterSwiftAppKitCore"],
            path: "Sources/SwifterSwiftAppKitIBInspectable"),
        .target(
            name: "SwifterSwiftTestResourcesiOS",
            path: "Tests/SwifterSwiftTests/ResourcesTests",
            exclude: [
                "Resources/tvOS"
            ],
            sources: [
                "BundleSupport/SwifterSwiftTestResourcesiOS.swift"
            ],
            resources: [
                .process("Resources/iOS")
            ]),
        .target(
            name: "SwifterSwiftTestResourcesTVOS",
            path: "Tests/SwifterSwiftTests/ResourcesTests",
            exclude: [
                "Resources/iOS"
            ],
            sources: [
                "BundleSupport/SwifterSwiftTestResourcesTVOS.swift"
            ],
            resources: [
                .process("Resources/tvOS")
            ]),
        .testTarget(
            name: "SwifterSwiftTests",
            dependencies: [
                "SwifterSwift",
                .target(
                    name: "SwifterSwiftTestResourcesiOS",
                    condition: .when(platforms: [.iOS])),
                .target(
                    name: "SwifterSwiftTestResourcesTVOS",
                    condition: .when(platforms: [.tvOS]))
            ],
            path: "Tests/SwifterSwiftTests",
            exclude: [
                // Exclude Interface Builder fixtures so the macOS package test destination doesn't try to compile
                // UIKit/tvOS resources with `ibtool` (which fails with "target device type \"mac\"").
                "ResourcesTests/BundleSupport",
                "ResourcesTests/Resources/iOS",
                "ResourcesTests/Resources/tvOS"
            ],
            resources: [
                .process("ResourcesTests/Resources")
            ])
    ])
