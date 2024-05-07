// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DTDesignSystem",
    platforms: [.iOS(.v16), .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DTDesignSystem",
            targets: ["DTDesignSystem"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DTDesignSystem",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "DTDesignSystemTests",
            dependencies: ["DTDesignSystem"]
        ),
    ]
)
