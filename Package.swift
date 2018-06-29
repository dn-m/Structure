// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Structure",
    products: [
        .library(name: "StructureWrapping", targets: ["StructureWrapping"]),
        .library(name: "Destructure", targets: ["Destructure"]),
        .library(name: "Restructure", targets: ["Restructure"]),
        .library(name: "Algebra", targets: ["Algebra"]),
        .library(name: "DataStructures", targets: ["DataStructures"]),
        .library(name: "Combinatorics", targets: ["Combinatorics"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/PerformanceTesting.git", .branch("master"))
    ],
    targets: [

        // Sources
        .target(name: "Restructure"),
        .target(name: "Destructure"),
        .target(name: "StructureWrapping"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "DataStructures", dependencies: ["Algebra", "Restructure", "Destructure", "StructureWrapping"]),
        .target(name: "Combinatorics", dependencies: ["Destructure"]),

        // Tests
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        .testTarget(name: "DataStructuresTests", dependencies: ["DataStructures"]),
        .testTarget(name: "CombinatoricsTests", dependencies: ["Combinatorics"]),
        .testTarget(name: "DestructureTests", dependencies: ["Destructure"]),
        .testTarget(name: "RestructureTests", dependencies: ["Restructure"]),

        // Performance Tests
        .testTarget(name: "DestructurePerformanceTests", dependencies: ["Destructure", "PerformanceTesting"]),
        .testTarget(name: "RestructurePerformanceTests", dependencies: ["Restructure", "PerformanceTesting"]),
        .testTarget(name: "AlgebraPerformanceTests", dependencies: ["Algebra", "PerformanceTesting"])
    ]
)
