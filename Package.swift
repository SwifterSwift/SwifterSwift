// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwifterSwift",
    products: [
        .library(name: "SwifterSwift", targets: ["SwifterSwift"])
    ],
    dependencies: [],
    targets: [
        .target(name: "SwifterSwift", dependencies: [])
    ]
)
