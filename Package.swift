// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Classification",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Classification",
            targets: ["Classification"]),
    ],
    dependencies: [
        .package(name: "DataStructure", url: "https://github.com/StarlangSoftware/DataStructure-Swift.git", .exact("1.0.4")),
        .package(name: "Math", url: "https://github.com/StarlangSoftware/Math-Swift.git", .exact("1.0.7")),
        .package(name: "Sampling", url: "https://github.com/StarlangSoftware/Sampling-Swift.git", .exact("1.0.4")),
        .package(name: "Util", url: "https://github.com/StarlangSoftware/Util-Swift.git", .exact("1.0.4"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Classification",
            dependencies: ["DataStructure", "Math", "Sampling", "Util"]),
        .testTarget(
            name: "ClassificationTests",
            dependencies: ["Classification"]),
    ]
)
