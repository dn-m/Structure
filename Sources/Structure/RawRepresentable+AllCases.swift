//
//  RawRepresentable+AllCases.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

public extension RawRepresentable where Self: Hashable {

    /// All cases of a given `enum`.
    ///
    /// **Example:**
    /// ```
    /// enum ABOrC: String { case a,b,c }
    ///
    /// print(ABorC.allCases.joined(separator: ","))
    /// ```
    static var cases: [Self] {
        return iterateEnum(Self.self).map { $0 }
    }
}

/**
 Iterate over an Enum type.
 */
private func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {

    var i = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &i) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }

}
