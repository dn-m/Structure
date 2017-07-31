//
//  Matrix.swift
//  Collections
//
//  Created by James Bean on 12/10/16.
//
//

/// 2-dimensional matrix with user-definable dimensions, parameterized over any type `T`.
public struct Matrix <T> {

    /// Amount of rows.
    fileprivate let rowCount: Int

    /// Amount of columns.
    fileprivate let columnCount: Int

    /// Items of type `T` stored as `[row, row, row, ...]`
    fileprivate var grid: [T] = []

    // MARK: - Initializers

    /// - returns: Array of rows.
    public var rows: [[T]] {
        return (0 ..< rowCount).map { self[row: $0] }
    }

    /// - returns: Array of columns.
    public var columns: [[T]] {
        return (0 ..< columnCount).map { self[column: $0] }
    }

    /// Create a `Matrix` with the given dimensions and given `defaultValue`.
    public init(height rowCount: Int, width columnCount: Int, initial: T) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.grid = Array(repeating: initial, count: Int(rowCount * columnCount))
    }

    // MARK: - Subscripts

    /// Get and set the value for the given `row` and `column`, if these are valid indices.
    /// Otherwise, `nil` is returned or nothing is set.
    public subscript (row: Int, column: Int) -> T {

        get {

            guard let index = index(row, column) else {
                fatalError("Index out of bounds")
            }

            return grid[index]
        }

        set {

            guard let index = index(row, column) else {
                fatalError("Index out of bounds")
            }

            grid[index] = newValue
        }
    }

    /// Get and set an row of values.
    public subscript (row row: Int) -> [T] {

        get {
            let startIndex = row * columnCount
            let endIndex = row * columnCount + columnCount
            return Array(grid[startIndex ..< endIndex])
        }

        set {
            let startIndex = row * columnCount
            let endIndex = row * columnCount + columnCount
            grid.replaceSubrange(startIndex ..< endIndex, with: newValue)
        }
    }

    /// Get and set a column of values.
    public subscript (column column: Int) -> [T] {

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

        guard row < rowCount && column < columnCount else {
            return nil
        }

        return row * columnCount + column
    }
}

extension Matrix: Collection {

    // MARK: - `Collection`

    /// Index after given index `i`.
    public func index(after i: Int) -> Int {

        guard i != endIndex else {
            fatalError("Cannot increment endIndex")
        }

        return i + 1
    }

    /// Start index.
    public var startIndex: Int {
        return 0
    }

    /// End index.
    public var endIndex: Int {
        return grid.count
    }

    /// - returns: Element at the given `index`.
    public subscript (index: Int) -> T {
        return grid[index]
    }
}

extension Matrix where T: Equatable {

    /// - returns: `true` if all values of both matrices are equivalent. Otherwise, `false`.
    public static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.grid == rhs.grid
    }
}

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
            return "\(value)".characters.count
        }

        /// - warning: Don't use `\t`, though. Doesn't register correctly.
        func format <T> (_ row: [T]) -> String {

            let separator = "  "

            let columnWidth = columns
                .flatMap { $0.flatMap(width) }
                .max() ?? 0

            return row
                .map { "\($0)\(separator)\(space(columnWidth - width($0)))" }
                .joined()
        }

        return rows.map(format).joined(separator: "\n")
    }
}
