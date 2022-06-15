// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwifterSwift",
    platforms: [
        .iOS(.v10),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(name: "SwifterSwift", targets: ["SwifterSwift"])
    ],
    targets: [
        .target(name: "SwifterSwift"),
        .testTarget(
            name: "SwifterSwiftTests",
            dependencies: ["SwifterSwift"],
            path: "Tests",
            exclude: ["Info.plist"],
            resources: [.process("ResourcesTests/Resources")])
    ])
