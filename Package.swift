// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Structure",
    products: [
        .library(name: "Destructure", targets: ["Destructure"]),
        .library(name: "Algebra", targets: ["Algebra"]),
        .library(name: "DataStructures", targets: ["DataStructures"]),
        .library(name: "Combinatorics", targets: ["Combinatorics"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/PerformanceTesting.git", .branch("master"))
    ],
    targets: [

        // Sources
        .target(name: "Destructure"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "DataStructures", dependencies: ["Algebra", "Destructure"]),
        .target(name: "Combinatorics", dependencies: ["Destructure"]),

        // Tests
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        .testTarget(name: "DataStructuresTests", dependencies: ["DataStructures"]),
        .testTarget(name: "CombinatoricsTests", dependencies: ["Combinatorics"]),
        .testTarget(name: "DestructureTests", dependencies: ["Destructure"]),

        // Performance Tests
        .testTarget(
            name: "DataStructuresPerformanceTests",
            dependencies: ["DataStructures", "PerformanceTesting"]
        ),
        .testTarget(
            name: "AlgebraPerformanceTests",
            dependencies: ["Algebra", "PerformanceTesting"]
        )
    ]
)
