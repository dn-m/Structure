//
//  ZipToLongest.swift
//  DataStructures
//
//  Created by James Bean on 7/24/18.
//

/// - Returns: A `ZipToLongest2Sequence` for the two given sequences, using `fill1` and
/// `fill2` as default values if the other sequence is longer.
public func zip <Sequence1,Sequence2> (
    _ sequence1: Sequence1,
    _ sequence2: Sequence2,
    fill1: Sequence1.Element,
    fill2: Sequence2.Element
) -> ZipToLongest2Sequence<Sequence1,Sequence2>
{
    return ZipToLongest2Sequence(sequence1, sequence2, fill1: fill1, fill2: fill2)
}

/// - Returns: A `ZipToLongest2Sequence` for the two given sequences, using `fill` and
/// `fill` as default values if the other sequence is longer.
public func zip <Sequence1,Sequence2> (
    _ sequence1: Sequence1,
    _ sequence2: Sequence2,
    fill: Sequence1.Element
) -> ZipToLongest2Sequence<Sequence1,Sequence2>
    where Sequence1.Element == Sequence2.Element
{
    return zip(sequence1, sequence2, fill1: fill, fill2: fill)
}

/// - Returns: A `ZipToLongest3Sequence` for the three given sequences, using `firstFill`,
/// `secondFill`, and `thirdFill` as default values if the other sequences are longer.
public func zip <Sequence1,Sequence2,Sequence3> (
    _ sequence1: Sequence1,
    _ sequence2: Sequence2,
    _ sequence3: Sequence3,
    fill1: Sequence1.Element,
    fill2: Sequence2.Element,
    fill3: Sequence3.Element
) -> ZipToLongest3Sequence<Sequence1,Sequence2,Sequence3>
{
    return ZipToLongest3Sequence(
        sequence1,
        sequence2,
        sequence3,
        fill1: fill1,
        fill2: fill2,
        fill3: fill3
    )
}

/// - Returns: A `ZipToLongest3Sequence` for the three given sequences, using `fill` as a default
/// value if the other sequences are longer.
public func zip <Sequence1,Sequence2,Sequence3> (
    _ sequence1: Sequence1,
    _ sequence2: Sequence2,
    _ sequence3: Sequence3,
    fill: Sequence1.Element
) -> ZipToLongest3Sequence<Sequence1,Sequence2,Sequence3>
    where Sequence1.Element == Sequence2.Element, Sequence2.Element == Sequence3.Element
{
    return ZipToLongest3Sequence(
        sequence1,
        sequence2,
        sequence3,
        fill1: fill,
        fill2: fill,
        fill3: fill
    )
}

/// Lazy sequence zipping two `Sequence` values together to the longest of the two sequences,
/// filling in the others with the given `fill1`, and `fill2` values.
public struct ZipToLongest2Sequence <Sequence1: Sequence, Sequence2: Sequence>
    : IteratorProtocol, Sequence
{
    private var iterator1: Sequence1.Iterator
    private var iterator2: Sequence2.Iterator
    private let fill1: Sequence1.Element
    private let fill2: Sequence2.Element

    init(
        _ sequence1: Sequence1,
        _ sequence2: Sequence2,
        fill1: Sequence1.Element,
        fill2: Sequence2.Element
    )
    {
        self.iterator1 = sequence1.makeIterator()
        self.iterator2 = sequence2.makeIterator()
        self.fill1 = fill1
        self.fill2 = fill2
    }

    public mutating func next() -> (Sequence1.Element, Sequence2.Element)? {
        let firstValue = iterator1.next()
        let secondValue = iterator2.next()
        guard firstValue != nil || secondValue != nil else { return nil }
        return (firstValue ?? fill1, secondValue ?? fill2)
    }
}

/// Lazy sequence zipping three `Sequence` values together to the longest of the three sequences,
/// filling in the others with the given `fill1`, `fill2`, and `fill3` values.
public struct ZipToLongest3Sequence <Sequence1: Sequence, Sequence2: Sequence, Sequence3: Sequence>
    : IteratorProtocol, Sequence
{
    private var iterator1: Sequence1.Iterator
    private var iterator2: Sequence2.Iterator
    private var iterator3: Sequence3.Iterator
    private let fill1: Sequence1.Element
    private let fill2: Sequence2.Element
    private let fill3: Sequence3.Element

    init(
        _ sequence1: Sequence1,
        _ sequence2: Sequence2,
        _ sequence3: Sequence3,
        fill1: Sequence1.Element,
        fill2: Sequence2.Element,
        fill3: Sequence3.Element
    )
    {
        self.iterator1 = sequence1.makeIterator()
        self.iterator2 = sequence2.makeIterator()
        self.iterator3 = sequence3.makeIterator()
        self.fill1 = fill1
        self.fill2 = fill2
        self.fill3 = fill3
    }

    public mutating func next() -> (Sequence1.Element, Sequence2.Element, Sequence3.Element)? {
        let value1 = iterator1.next()
        let value2 = iterator2.next()
        let value3 = iterator3.next()
        guard value1 != nil || value2 != nil || value3 != nil else { return nil }
        return (value1 ?? fill1, value2 ?? fill2, value3 ?? fill3)
    }
}
