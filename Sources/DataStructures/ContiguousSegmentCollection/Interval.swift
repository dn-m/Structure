//
//  Interval.swift
//  DataStructures
//
//  Created by James Bean on 8/22/18.
//

public struct Interval <Metric: SignedNumeric & Comparable> {

    // MARK: - Nested Types

    /// The `Bound` of an `Interval`.
    public enum Bound {

        // MARK: - Cases

        /// Open bound.
        case open(Metric)

        /// Closed bound.
        case closed(Metric)

        // MARK: - Computed Properties

        var value: Metric {
            switch self {
            case .open(let value):
                return value
            case .closed(let value):
                return value
            }
        }
    }

    // MARK: - Instance Properties

    /// Lower bound.
    let lower: Bound

    /// Upper bound.
    let upper: Bound

    // MARK: - Initializers

    /// Create an `Interval` with the two given `Bound` values.
    public init(_ lower: Bound, _ upper: Bound) {
        precondition(Interval.boundsAreValid(lower, upper), "Invalid Bounds: \(lower), \(upper)")
        self.lower = lower
        self.upper = upper
    }
}

infix operator ..: RangeFormationPrecedence

/// - Returns: An `Interval` composed of the two given `Bound` values.
public func .. <M> (lhs: Interval<M>.Bound, rhs: Interval<M>.Bound) -> Interval<M>
    where M: SignedNumeric & Comparable
{
    return Interval(lhs,rhs)
}

extension Interval: Intervallic {

    /// - Returns: The length of this `Interval`.
    public var length: Metric {
        return upper.value - lower.value
    }

    /// - Returns: `true` if the given `target` is contained within the `length` of this `Interval`.
    /// Otherwise, `false`.
    public func contains(_ target: Metric) -> Bool {
        switch (lower,upper) {
        case (.closed(let lower), .closed(let upper)):
            return target >= lower && target <= upper
        case (.closed(let lower), .open(let upper)):
            return target >= lower && target < upper
        case (.open(let lower), .open(let upper)):
            return target > lower && target < upper
        case (.open(let lower), .closed(let upper)):
            return target > lower && target <= upper
        }
    }
}

extension Interval {
    private static func boundsAreValid(_ lower: Bound, _ upper: Bound) -> Bool {
        switch (lower,upper) {
        case (.closed, .closed):
            return upper.value >= lower.value
        default:
            return upper.value > lower.value
        }
    }
}
