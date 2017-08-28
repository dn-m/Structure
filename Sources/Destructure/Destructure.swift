//
//  ListProcessing.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Collection {

    /// 2-tuple containing the `head` `Element` and `tail` `[Element]` of `Self`
    public var destructured: (Element, SubSequence)? {
        guard let first = first else { return nil }
        return (first, dropFirst())
    }
}
