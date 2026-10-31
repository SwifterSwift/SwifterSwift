// swift-tools-version: 6.2

import PackageDescription

/// Every area ships as its own library product, `SwifterSwift<Area>`, with a matching `SwifterSwift<Area>Tests` test
/// target. The `SwifterSwift` product re-exports all of them.
///
/// To add an area, append its name here, create `Sources/SwifterSwift<Area>` and `Tests/SwifterSwift<Area>Tests`, and
/// re-export the module from `Sources/SwifterSwift/SwifterSwift.swift`.
let areas = [
    "Stdlib",
    "Foundation",
    "CoreGraphics",
    "UIKit",
    "AppKit",
    "CoreLocation",
    "MapKit",
    "SpriteKit",
    "CryptoKit",
    "HealthKit"
]

/// Resources bundled with an area. Foundation ships a privacy manifest because its `UserDefaults` extensions use a
/// required-reason API.
let resources: [String: [Resource]] = [
    "Foundation": [.process("PrivacyInfo.xcprivacy")]
]

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances")
]

var products: [Product] = [
    .library(name: "SwifterSwift", targets: ["SwifterSwift"])
]

var targets: [Target] = [
    .target(
        name: "SwifterSwift",
        dependencies: areas.map { .target(name: "SwifterSwift\($0)") },
        swiftSettings: swiftSettings
    )
]

for area in areas {
    products.append(.library(name: "SwifterSwift\(area)", targets: ["SwifterSwift\(area)"]))
    targets.append(
        .target(
            name: "SwifterSwift\(area)",
            resources: resources[area],
            swiftSettings: swiftSettings
        )
    )
    targets.append(
        .testTarget(
            name: "SwifterSwift\(area)Tests",
            dependencies: [.target(name: "SwifterSwift\(area)")],
            swiftSettings: swiftSettings
        )
    )
}

let package = Package(
    name: "SwifterSwift",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
        .macCatalyst(.v17)
    ],
    products: products,
    targets: targets,
    swiftLanguageModes: [.v6]
)
