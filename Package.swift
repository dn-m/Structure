// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Structure",
    products: [
        .library(name: "Destructure", targets: ["Destructure"]),
        .library(name: "Algebra", targets: ["Algebra"]),
        .library(name: "DataStructures", targets: ["DataStructures"]),
        .library(name: "Algorithms", targets: ["Algorithms"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/PerformanceTesting", .branch("master"))
    ],
    targets: [

        // Sources
        .target(name: "Destructure"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "DataStructures", dependencies: ["Destructure", "Algebra", "Algorithms"]),
        .target(name: "Algorithms", dependencies: ["Destructure"]),

        // Tests
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        .testTarget(name: "DataStructuresTests", dependencies: ["DataStructures"]),
        .testTarget(name: "DestructureTests", dependencies: ["Destructure"]),
        .testTarget(name: "AlgorithmsTests", dependencies: ["Algorithms"]),

        // Performance Tests
        .testTarget(
            name: "AlgebraPerformanceTests",
            dependencies: ["Algebra", "PerformanceTesting"]
        ),
        .testTarget(
            name: "AlgorithmsPerformanceTests",
            dependencies: ["Algorithms", "PerformanceTesting"]
        )
    ]
)
