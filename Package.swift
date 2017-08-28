// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    products: [
        .library(name: "DictionaryProtocol", targets: ["DictionaryProtocol"]),
        .library(name: "StructureWrapping", targets: ["StructureWrapping"]),
        .library(name: "Destructure", targets: ["Destructure"]),
        .library(name: "Restructure", targets: ["Restructure"]),
        .library(name: "Structure", targets: ["Structure"]),
        .library(name: "Algebra", targets: ["Algebra"]),
        .library(name: "DataStructures", targets: ["DataStructures"]),
        .library(name: "Predicates", targets: ["Predicates"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/PerformanceTesting.git", .branch("master"))
    ],
    targets: [

        // Sources
        .target(name: "Restructure"),
        .target(name: "Destructure"),
        .target(name: "StructureWrapping"),
        .target(name: "DictionaryProtocol"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "Structure", dependencies: ["Algebra"]),
        .target(name: "DataStructures", dependencies: ["Algebra", "Restructure", "Destructure", "DictionaryProtocol", "StructureWrapping", "Structure", "Predicates"]),
        .target(name: "Predicates", dependencies: ["Destructure"]),

        // Tests
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        .testTarget(name: "StructureTests", dependencies: ["Structure"]),
        .testTarget(name: "DataStructuresTests", dependencies: ["DataStructures"]),
        .testTarget(name: "PredicatesTests", dependencies: ["Predicates"]),

        // Performance Tests
        .testTarget(name: "StructurePerformanceTests",
            dependencies: ["Structure", "PerformanceTesting"]),
        .testTarget(name: "DestructurePerformanceTests", dependencies: ["Destructure", "PerformanceTesting"])
    ]
)
