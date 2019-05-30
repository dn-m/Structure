//
//  SequenceWrapping.swift
//  Collections
//
//  Created by James Bean on 12/9/16.
//
//

/// `SequenceWrapping` is a type-erasing protocol that allows a `Sequence`-conforming
/// structure to wrap any underlying `Sequence` implementation.
///
/// For example, `PitchSet` and `PitchCollection` are both containers for `Pitch` values, and
/// should both be able to be used as `Sequence` conforming structures.
///
/// By conforming to this protocol, the `PitchSet` can use a `Set<Pitch>` as its underlying
/// model, while `PitchSequence` can use an `Array<Pitch>` as its underlying model.
///
/// In the conforming `struct`, it is necessary to add a private `var` which is an
/// implementation of a `Sequence`-conforming `struct`, which is then given by the
/// `sequence` getter.
///
/// In the `init` method of the conforming `struct`, set the value of this private `var` with
/// the given `sequence`.
public protocol SequenceWrapping: Sequence {

    // MARK: Associated Types

    /// Wrapped `Collection`-conforming type.
    associatedtype Base: Sequence

    // MARK: - Instance Properties

    /// Wrapped `Collection`-conforming type.
    var base: Base { get }
}

extension SequenceWrapping {

    // MARK: - Sequence

    /// - returns a generator over the elements of this sequence.
    public func makeIterator() -> Base.Iterator {
        return base.makeIterator()
    }
}
