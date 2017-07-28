// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    targets: [

        // Sources
        .target(name: "Algebra"),
        .target(name: "Destructure"),
        .target(name: "LinkedList"),
        .target(name: "Stack", dependencies: ["Structure"]),
        .target(name: "Matrix", dependencies: ["Structure"]),
        .target(name: "Tree", dependencies: ["Structure", "Destructure"]),
        .target(name: "CircularArray", dependencies: ["Structure"]),
        .target(name: "OrderedDictionary", dependencies: ["Structure"]),
        .target(name: "SortedArray", dependencies: ["Structure"]),
        .target(name: "SortedDictionary", dependencies: ["SortedArray", "Structure"]),

        // Tests
        .testTarget(name: "LinkedListTests", dependencies: ["LinkedList"]),
        .testTarget(name: "StackTests", dependencies: ["Stack"]),
        .testTarget(name: "MatrixTests", dependencies: ["Matrix"]),
        .testTarget(name: "DestructureTests", dependencies: ["Structure", "Destructure"]),
        .testTarget(name: "TreeTests", dependencies: ["Tree"]),
        .testTarget(name: "CircularArrayTests", dependencies: ["CircularArray"]),
        .testTarget(name: "OrderedDictionaryTests", dependencies: ["OrderedDictionary"]),
        .testTarget(name: "SortedArrayTests", dependencies: ["Algebra", "Structure"]),
        .testTarget(name: "SortedDictionaryTests", dependencies: ["SortedArray"]),


        // FIXME: Ultimately get rid of this
        .target(name: "Structure", dependencies: ["Algebra"]),
        .testTarget(name: "StructureTests", dependencies: ["Structure"]),
    ]
)
