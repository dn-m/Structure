//
//  IntervalRelation.swift
//  SumType
//
//  Created by James Bean on 5/17/18.
//

/// Implementation of
/// [Allen's Interval Algebra](https://en.wikipedia.org/wiki/Allen%27s_interval_algebra).
///
/// **Background**
///
/// From [Thomas A. Alspaugh](http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html#Allen1983-mkti):
/// > In 1983 James F. Allen published a paper in which he proposed thirteen basic relations
/// between time intervals that are **distinct**, **exhaustive**, and **qualitative**.
///
/// > - **Distinct** because no pair of definite intervals can be related by
/// more than one of the relationships
/// > - **Exhaustive** because any pair of definite intervals are described by
/// one of the relations
/// > - **Qualitative** (rather than quantitative) because no numeric time spans are considered
///
/// The naming conventions used in this implementation are those of
/// [Allen](https://en.wikipedia.org/wiki/James_F._Allen), refined by
/// [Krokhin et al.](http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html#Allen1983-mkti).
///
public enum IntervalRelation: InvertibleEnum {

    // MARK: - Cases

    /// `x` _precedes_ `y`
    ///
    ///     x: |---|
    ///     y:       |---|
    ///
    case precedes

    /// `x` _meets_ `y`
    ///
    ///     x: |----|
    ///     y:      |----|
    ///
    case meets

    /// `x` _overlaps_ `y`
    ///
    ///     x: |------|
    ///     y:    |------|
    ///
    case overlaps

    /// `x` _is finished by_ `y`
    ///
    ///     x: |---------|
    ///     y:      |----|
    ///
    case finishedBy

    /// `x` _contains_ `y`
    ///
    ///     x: |----------|
    ///     y:    |----|
    ///
    case contains

    /// `x` _starts_ `y`
    ///
    ///     x: |-----|
    ///     y: |----------|
    ///
    case starts

    /// `x` _equals_ `y`
    ///
    ///     x: |----------|
    ///     y: |----------|
    ///
    case equals

    /// `x` _is started by_ `y`
    ///
    ///     x: |----------|
    ///     y: |-----|
    ///
    case startedBy

    /// `x` _is contained by_ `y`
    ///
    ///
    ///     x:    |----|
    ///     y: |----------|
    ///
    case containedBy

    /// `x` _finishes_ `y`
    ///
    ///     x:      |-----|
    ///     y: |----------|
    ///
    case finishes

    /// `x` _is overlapped by_ `y`
    ///
    ///     x:    |------|
    ///     y: |------|
    ///
    case overlappedBy

    /// `x` _is met by_ `y`
    ///
    ///     x:      |----|
    ///     y: |----|
    ///
    case metBy

    /// `x` _is preceded by_ `y`
    ///
    ///     x:       |---|
    ///     y: |---|
    ///
    case precededBy
}

extension RangeProtocol {

    /// - Returns: The `IntervalRelation` between this `RangeProtocol`-conforming type and another.
    public func relation(with range: Self) -> IntervalRelation {

        if upperBound < range.lowerBound {
            return .precedes
        } else if upperBound == range.lowerBound {
            return .meets
        } else if lowerBound < range.lowerBound && range.openContains(upperBound) {
            return .overlaps
        } else if upperBound == range.upperBound && openContains(range.lowerBound) {
            return .finishedBy
        } else if openContains(range.lowerBound) && openContains(range.upperBound) {
            return .contains
        } else if lowerBound == range.lowerBound && range.openContains(upperBound) {
            return .starts
        } else if lowerBound == range.lowerBound && openContains(range.upperBound) {
            return .startedBy
        } else if range.openContains(lowerBound) && range.openContains(upperBound) {
            return .containedBy
        } else if upperBound == range.upperBound && range.openContains(lowerBound) {
            return .finishes
        } else if upperBound > range.upperBound && range.openContains(lowerBound) {
            return .overlappedBy
        } else if lowerBound == range.upperBound {
            return .metBy
        } else if lowerBound > range.upperBound {
            return .precededBy
        }

        return .equals
    }

    /// - returns: `true` if the given `value` is greater than the `lowerBound` and
    /// `upperBound`. Otherwise, `false`.
    private func openContains(_ value: Bound) -> Bool {
        return value > lowerBound && value < upperBound
    }
}
