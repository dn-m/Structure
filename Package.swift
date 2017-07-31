// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    products: [
        .library(name: "Structure", targets: ["Structure"])
    ],
    targets: [
        .target(name: "Structure"),
        .testTarget(name: "StructureTests", dependencies: ["Structure"])
    ]
)
