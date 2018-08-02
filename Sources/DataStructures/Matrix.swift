//
//  Matrix.swift
//  Collections
//
//  Created by James Bean on 12/10/16.
//
//

/// Two-dimensional matrix with user-definable dimensions, parameterized over the generic `Element`.
///
/// **Example Usage**
///
/// It is quite pleasant to fill a new `Matrix` value.
///
///     let matrix = Matrix(height: 3, width: 3, initial: 0)
///     // => 0,0,0
///     //    0,0,0
///     //    0,0,0
///
/// You can ask what the value is at a given row and column.
/// > **Warning**: Your program will crash if the row or column is invalid — so, be careful!
///
///     matrix[row: 1, column: 2] // => 0
///
/// You can also set the value at the given row and column.
///
///     matrix[row: 0, column: 1] = 1
///     // => 0,1,0
///     //    0,0,0
///     //    0,0,0
///
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

    /// Create a `Matrix` with the given dimensions and the given `initial` value.
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

    // MARK: - CustomStringConvertible

    /// Printed description of `Matrix`.
    public var description: String {

        /// - Returns: Whitespace with the given width.
        func space(_ amount: Int) -> String {
            return String(repeating: " ", count: amount)
        }

        /// - Returns: Width of a string-interpolated representation of any value.
        func width <T> (_ value: T) -> Int {
            return "\(value)".count
        }

        /// - Warning: Don't use `\t`, though. Doesn't register correctly.
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
