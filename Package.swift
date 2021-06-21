// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GherkGen",
    products: [
        .executable(name: "GherkGen", targets: ["GherkGen"])
    ],
    dependencies: [
        .package(name: "GherkParser", url: "https://github.com/intelygenz/IOS-GherkParser", from: "0.5.0")
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
