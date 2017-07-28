// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Structure",
    targets: [

        // Sources
        .target(name: "StructureWrapping"),
        .target(name: "Destructure"),
        .target(name: "Algebra", dependencies: ["Destructure"]),
        .target(name: "Zip3Sequence"),
        .target(name: "LinkedList"),
        .target(name: "Matrix"),
        .target(name: "Stack", dependencies: ["Algebra"]),
        .target(name: "ReferenceTree", dependencies: ["Structure"]),
        .target(name: "ReferenceGraph"),
        .target(name: "Tree", dependencies: ["Structure", "Destructure", "Stack"]),
        .target(name: "CircularArray", dependencies: ["Structure"]),
        .target(name: "SortedArray", dependencies: ["Algebra", "StructureWrapping"]),
        .target(name: "DictionaryProtocol"),
        .target(name: "OrderedDictionary", dependencies: ["DictionaryProtocol","Structure"]),
        .target(name: "SortedDictionary", dependencies: ["DictionaryProtocol", "SortedArray", "Structure"]),

        // Tests
        .testTarget(name: "Zip3SequenceTests", dependencies: ["Zip3Sequence"]),
        .testTarget(name: "DestructureTests", dependencies: ["Structure", "Destructure"]),
        .testTarget(name: "LinkedListTests", dependencies: ["LinkedList"]),
        .testTarget(name: "StackTests", dependencies: ["Stack"]),
        .testTarget(name: "MatrixTests", dependencies: ["Matrix"]),
        .testTarget(name: "ReferenceTreeTests", dependencies: ["ReferenceTree"]),
        .testTarget(name: "ReferenceGraphTests", dependencies: ["ReferenceGraph"]),
        .testTarget(name: "TreeTests", dependencies: ["Tree"]),
        .testTarget(name: "CircularArrayTests", dependencies: ["CircularArray"]),
        .testTarget(name: "OrderedDictionaryTests", dependencies: ["OrderedDictionary"]),
        .testTarget(name: "SortedArrayTests", dependencies: ["Algebra", "Structure"]),
        .testTarget(name: "SortedDictionaryTests", dependencies: ["SortedDictionary"]),
        .testTarget(name: "DictionaryProtocolTests", dependencies: ["DictionaryProtocol"]),
        // FIXME: Ultimately get rid of this
        .target(name: "Structure", dependencies: ["Algebra"]),
        .testTarget(name: "StructureTests", dependencies: ["Structure"]),
    ]
)
