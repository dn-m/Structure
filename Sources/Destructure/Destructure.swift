//
//  ListProcessing.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Sequence {

    /// 2-tuple containing the `head` `Element` and `tail` `[Element]` of `Self`
    public var destructured: (Element, AnySequence<Element>)? {
        var iterator = makeIterator()
        guard let first = iterator.next() else { return nil }
        return (first, AnySequence(IteratorSequence(iterator)))
    }
}
