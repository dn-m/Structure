// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    products: [
        .library(name: "Destructure", targets: ["Destructure"]),
        .library(name: "Structure", targets: ["Structure"]),
        .library(name: "Algebra", targets: ["Algebra"])
    ],
    targets: [
        .target(name: "Destructure"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "Structure", dependencies: ["Algebra"]),
        .testTarget(name: "StructureTests", dependencies: ["Structure"])
    ]
)
