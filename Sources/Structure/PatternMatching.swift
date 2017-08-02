//
//  SortedDictionary.swift
//  Collections
//
//  Created by James Bean on 07/28/17.
//
//

/// - Returns: `true` if the given `array` contains the given `value`.
public func ~= <S: Sequence> (array: S, value: S.Element) -> Bool where S.Element: Equatable {
    return array.contains(value)
}
