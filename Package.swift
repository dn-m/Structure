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
        .library(name: "DataStructures", targets: ["DataStructures"])
    ],
    targets: [

        // Sources
        .target(name: "Restructure"),
        .target(name: "Destructure"),
        .target(name: "StructureWrapping"),
        .target(name: "DictionaryProtocol"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "Structure", dependencies: ["Algebra"]),
        .target(name: "DataStructures", dependencies: ["Algebra", "Structure", "DictionaryProtocol", "StructureWrapping"]),

        // Tests
        .testTarget(name: "StructureTests", dependencies: ["Structure"]),
        .testTarget(name: "DataStructuresTests", dependencies: ["DataStructures"])
    ]
)
