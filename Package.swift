// swift-tools-version:5.8
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
        .library(name: "SwifterSwift", targets: ["SwifterSwift"])
    ],
    targets: [
        .target(
            name: "SwifterSwift",
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures")
            ]),
        .testTarget(
            name: "SwifterSwiftTests",
            dependencies: ["SwifterSwift"],
            path: "Tests",
            exclude: ["Info.plist"],
            resources: [.process("ResourcesTests/Resources")],
            swiftSettings: [
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures")
            ])
    ])
