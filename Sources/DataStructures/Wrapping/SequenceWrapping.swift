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
///
/// - TODO: Consider removing `ExpressibleByArrayLiteral` and `init` requirements.
public protocol SequenceWrapping: Sequence, ExpressibleByArrayLiteral {

    // MARK: Associated Types

    // MARK: - Instance Properties

    /// `AnySequence` wrapper that provides shade for the domain specific implementation.
    var sequence: AnySequence<Element> { get }

    // MARK: - Initializers

    /// Create an `SequenceWrapping` with a `Sequence`.
    init <S> (_ sequence: S) where S: Sequence, S.Element == Element
}

extension SequenceWrapping {

    // MARK: - Sequence

    /// - returns a generator over the elements of this sequence.
    public func makeIterator() -> AnyIterator<Element> {

        let iterator = sequence.makeIterator()

        return AnyIterator {
            return iterator.next()
        }
    }
}
