// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    targets: [
        .target(name: "Algebra"),
        .target(name: "Structure", dependencies: ["Algebra"]),
        .target(name: "SortedArray", dependencies: ["Structure"]),
        .target(name: "SortedDictionary", dependencies: ["SortedArray", "Structure"]),
        .testTarget(name: "StructureTests", dependencies: ["Structure"]),
        .testTarget(name: "SortedArrayTests", dependencies: ["Algebra", "Structure"]),
        .testTarget(name: "SortedDictionaryTests", dependencies: ["SortedArray"])
    ]
)
