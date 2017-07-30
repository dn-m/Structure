// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    targets: [

        // Sources
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "Algorithms"),
        .target(name: "Bitwise"),
        .target(name: "CircularArray", dependencies: ["Algebra", "Destructure"]),
        .target(name: "Destructure"),
        .target(name: "DictionaryProtocol"),
        .target(name: "LinkedList"),
        .target(name: "Matrix"),
        .target(name: "Number", dependencies: ["Algebra"]),
        .target(name: "OrderedDictionary", dependencies: ["DictionaryProtocol"]),
        .target(name: "PatternMatching"),
        .target(name: "Predicates"),
        .target(name: "ReferenceGraph"),
        .target(name: "ReferenceTree", dependencies: ["Algebra", "Predicates"]),
        .target(name: "SortedArray", dependencies: ["Algebra", "StructureWrapping"]),
        .target(
            name: "SortedDictionary",
            dependencies: ["DictionaryProtocol", "SortedArray", "StructureWrapping"]
        ),
        .target(name: "Stack", dependencies: ["Algebra"]),
        .target(name: "StructureWrapping"),
        .target(name: "SumType", dependencies: ["Bitwise"]),
        .target(name: "Tree", dependencies: ["Algebra", "Destructure", "Stack"]),
        .target(name: "Zip3Sequence"),

        // Tests
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        .testTarget(name: "AlgorithmsTests", dependencies: ["Algorithms"]),
        .testTarget(name: "BitwiseTests", dependencies: ["Bitwise"]),
        .testTarget(name: "CircularArrayTests", dependencies: ["CircularArray"]),
        .testTarget(name: "DestructureTests", dependencies: ["Destructure"]),
        .testTarget(name: "DictionaryProtocolTests", dependencies: ["DictionaryProtocol"]),
        .testTarget(name: "LinkedListTests", dependencies: ["LinkedList"]),
        .testTarget(name: "MatrixTests", dependencies: ["Matrix"]),
        .testTarget(name: "OrderedDictionaryTests", dependencies: ["OrderedDictionary"]),
        .testTarget(name: "PredicatesTests", dependencies: ["Predicates"]),
        .testTarget(name: "ReferenceGraphTests", dependencies: ["ReferenceGraph"]),
        .testTarget(name: "ReferenceTreeTests", dependencies: ["ReferenceTree"]),
        .testTarget(name: "SortedArrayTests", dependencies: ["SortedArray"]),
        .testTarget(name: "SortedDictionaryTests", dependencies: ["SortedDictionary"]),
        .testTarget(name: "StackTests", dependencies: ["Stack"]),
        .testTarget(name: "SumTypeTests", dependencies: ["SumType"]),
        .testTarget(name: "TreeTests", dependencies: ["Tree"]),
        .testTarget(name: "Zip3SequenceTests", dependencies: ["Zip3Sequence"]),
    ]
)
