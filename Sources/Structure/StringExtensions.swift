//
//  StringExtensions.swift
//  Collections
//
//  Created by James Bean on 1/16/17.
//
//

public extension String {

    /// - returns: The `Character` value at the given `index`, if available. Otherwise `nil`.
    subscript (index: Int) -> Character? {

        if index >= self.characters.count {
            return nil
        }

        return self[self.characters.index(self.startIndex, offsetBy: index)]
    }

    /// - returns: The `String` value at the given `index`, if available. Otherwise `nil`.
    subscript (index: Int) -> String? {
        let charOrNil: Character? = self[index]

        guard let char = charOrNil else {
            return nil
        }

        return String(char as Character)
    }

    /// - returns: The `String` value for the given `range`, if available. Otherwise `nil`.
    subscript (range: Range<Int>) -> String {
        return substring(
            with: Range(
                characters.index(startIndex, offsetBy: range.lowerBound) ..<
                characters.index(startIndex, offsetBy: range.upperBound)
            )
        )
    }

    /// - returns: Tuple of the first, and remaining string values, if available.
    /// Otherwise, `nil`.
    public var destructured: (String, String)? {

        guard let head: String = self[0] else {
            return nil
        }

        let tail: String = self[1..<self.characters.count]
        return (head, tail)
    }

    /// Injects the given `prefix` before each line of the given string
    ///
    /// - TODO: Don't add newline to last line (but check performance for iterating strategies)
    public mutating func indent(prefix: String = " ") {

        // Split up `self` by line
        let lines = characters
            .split(separator: "\n")
            .map(String.init)

        // Create the result, with the space needed (to avoid the cost of resizing)
        var result = ""
        result.reserveCapacity(characters.count + lines.count * prefix.characters.count)

        // Inject the given `prefix` before each line
        for line in lines {
            result += prefix
            result += line
            result += "\n"
        }

        self = result
    }

    /// Immutable variant of `indent(prefix:)`
    public func indented(prefix: String = " ") -> String {
        var copy = self
        copy.indent()
        return copy
    }
}
