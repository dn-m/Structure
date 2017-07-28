// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    targets: [
        .target(name: "Structure"),
        .target(name: "Algebra"),
        .testTarget(name: "StructureTests", dependencies: ["Structure"])
    ]
)
