//
//  SortedCollectionWrapping.swift
//  Collections
//
//  Created by James Bean on 7/15/17.
//
//

public protocol SortedCollectionWrapping: Collection {
    associatedtype Base: BidirectionalCollection
    var base: Base { get }
}

extension SortedCollectionWrapping {

    public func min() -> Base.Iterator.Element? {
        return base.first
    }

    public func max() -> Base.Iterator.Element? {
        return base.last
    }

    public func sorted() -> [Iterator.Element] {
        return Array(self)
    }
}
