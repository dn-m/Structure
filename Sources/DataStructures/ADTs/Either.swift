//
//  Either.swift
//  Collections
//
//  Created by James Bean on 7/11/17.
//
//

/// `Either` is a sum type which holds either of two generic values.
///
/// **Example Usage**
///
///     let one = Either<String,Int>.left("one")
///     let two = Either<String,Int>.right(2)
///
public enum Either <Left,Right> {

    // MARK: - Cases

    /// The left value.
    case left(Left)

    /// The right value.
    case right(Right)

    // MARK: - Instance Properties

    ///     let one = Either<String,Int>.left("one")
    ///     one.left // => .some("one")
    ///     one.right // => nil
    ///
    /// - Returns: The left value, if it is exists. Otherwise, `nil`.
    public var left: Left? {
        guard case let .left(value) = self else { return nil }
        return value
    }
    ///     let one = Either<String,Int>.right(1)
    ///     one.left // => nil
    ///     one.right // => .some(1)
    ///
    /// - Returns: The right value, if it is exists. Otherwise, `nil`.
    public var right: Right? {
        guard case let .right(value) = self else { return nil }
        return value
    }
}

extension Either: Codable where Left: Codable, Right: Codable {

    enum DecodingError: Error {
        case invalidCase
    }

    enum CodingKeys: String, CodingKey {
        case left
        case right
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Left.self, forKey: .left) {
            self = .left(value)
        } else if let value = try? container.decode(Right.self, forKey: .right) {
            self = .right(value)
        } else {
            throw DecodingError.invalidCase
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .left(value):
            try container.encode(value, forKey: .left)
        case let .right(value):
            try container.encode(value, forKey: .right)
        }
    }
}

extension Either: Equatable where Left: Equatable, Right: Equatable { }
extension Either: Hashable where Left: Hashable, Right: Hashable { }
