// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    targets: [
        .target(name: "Structure"),
        .testTarget(name: "StructureTests", dependencies: ["Structure"])
    ]
)
