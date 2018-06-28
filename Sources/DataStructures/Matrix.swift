//
//  Matrix.swift
//  Collections
//
//  Created by James Bean on 12/10/16.
//
//

import StructureWrapping

/// 2-dimensional matrix with user-definable dimensions, parameterized over any type `Element`.
public struct Matrix <Element> {

    // MARK: - Instance Properties

    /// Amount of rows.
    private let rowCount: Int

    /// Amount of columns.
    private let columnCount: Int

    /// Items of type `Element` stored as `[row, row, row, ...]`
    private var grid: [Element] = []

    /// - returns: Array of rows.
    public var rows: [[Element]] {
        return (0 ..< rowCount).map { self[row: $0] }
    }

    /// - returns: Array of columns.
    public var columns: [[Element]] {
        return (0 ..< columnCount).map { self[column: $0] }
    }

    // MARK: - Initializers

    /// Create a `Matrix` with the given dimensions and given `defaultValue`.
    public init(height rowCount: Int, width columnCount: Int, initial: Element) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.grid = Array(repeating: initial, count: Int(rowCount * columnCount))
    }

    // MARK: - Subscripts

    /// Get and set the value for the given `row` and `column`, if these are valid indices.
    /// Otherwise, `nil` is returned or nothing is set.
    public subscript (row: Int, column: Int) -> Element {
        get {
            guard let index = index(row, column) else { fatalError("Index out of bounds") }
            return grid[index]
        }
        set {
            guard let index = index(row, column) else { fatalError("Index out of bounds") }
            grid[index] = newValue
        }
    }

    /// Get and set an row of values.
    public subscript (row row: Int) -> [Element] {
        get {
            let startIndex = row * columnCount
            let endIndex = startIndex + columnCount
            return Array(grid[startIndex ..< endIndex])
        }
        set {
            let startIndex = row * columnCount
            let endIndex = startIndex + columnCount
            grid.replaceSubrange(startIndex ..< endIndex, with: newValue)
        }
    }

    /// Get and set a column of values.
    public subscript (column column: Int) -> [Element] {
        get {
            return (0 ..< rowCount).map { index in grid[index * columnCount + column] }
        }
        set {
            for i in 0 ..< rowCount {
                let index = i * columnCount + column
                grid[index] = newValue[i]
            }
        }
    }

    private func index(_ row: Int, _ column: Int) -> Int? {
        guard row < rowCount && column < columnCount else { return nil }
        return row * columnCount + column
    }
}

extension Matrix: CollectionWrapping {

    // MARK: - CollectionWrapping

    public var base: [Element] {
        return grid
    }
}

extension Matrix: Equatable where Element: Equatable { }

extension Matrix: CustomStringConvertible {

    public var description: String {

        /// - returns: Whitespace with the given width.
        func space(_ amount: Int) -> String {
            return String(repeating: " ", count: amount)
        }

        /// Returns the width of a string-interpolated representation of any value.
        ///
        /// - warning: Assumes primitive type with no fancier `CustomStringConvertible`
        /// implementation.
        func width(_ value: Any) -> Int {
            return "\(value)".count
        }

        /// - warning: Don't use `\t`, though. Doesn't register correctly.
        func format <Element> (_ row: [Element]) -> String {

            let separator = "  "

            let columnWidth = columns
                .flatMap { $0.compactMap(width) }
                .max() ?? 0

            return row
                .map { "\($0)\(separator)\(space(columnWidth - width($0)))" }
                .joined()
        }

        return rows.map(format).joined(separator: "\n")
    }
}
