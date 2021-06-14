// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GherkGen",
    dependencies: [
        .package(path: "../GherkParser")
    ],
    targets: [
        .target(
            name: "GherkGen",
            dependencies: ["GherkParser"]),
        .testTarget(
            name: "GherkGenTests",
            dependencies: ["GherkGen"]),
    ]
)
