// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"])
    ],
    targets: [
        .target(name: "DesignSystem", path: "Sources/DesignSystem"),
        .testTarget(name: "DesignSystemTests", dependencies: ["DesignSystem"])
    ]
)


