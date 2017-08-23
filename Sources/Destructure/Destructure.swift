//
//  ListProcessing.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Collection {

    // MARK: - List Processing

    /// First `Element` of a list.
    public var head: Element? {
        return first
    }

    /// Remaining `Elements` of a list.
    public var tail: SubSequence? {
        guard !isEmpty else { return nil }
        return dropFirst()
    }

    /// 2-tuple containing the `head` `Element` and `tail` `[Element]` of `Self`
    public var destructured: (Element, SubSequence)? {
        guard let head = head, let tail = tail else { return nil }
        return (head, tail)
    }
}
