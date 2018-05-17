//
//  StableSort.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension RangeReplaceableCollection where Index == Int  {

    public func stableSort(_ isOrderedBefore: @escaping (Element, Element) -> Bool) -> [Element] {

        var result = self
        let count = result.count

        var aux: [Element] = []
        aux.reserveCapacity(numericCast(count))

        func merge(_ lo: Index, _ mid: Index, _ hi: Index) {

            aux.removeAll(keepingCapacity: true)

            var i = lo
            var j = mid

            while i < mid && j < hi {
                if isOrderedBefore(result[j], result[i]) {
                    aux.append(result[j])
                    j += 1
                }
                else {
                    aux.append(result[i])
                    i += 1
                }
            }

            aux.append(contentsOf: result[i ..< mid])
            aux.append(contentsOf: result[j ..< hi])
            result.replaceSubrange(lo ..< hi, with: aux)
        }

        var sz: Int = 1
        while sz < count {
            for lo in stride(from: result.startIndex, to: result.endIndex - sz, by: sz * 2) {
                merge(lo, lo + sz, (lo + (sz * 2)).limited(notToExceed: count))
            }
            sz *= 2
        }
        return Array(result)
    }
}

extension Int {
    func limited(notToExceed maximum: Int) -> Int {
        return self >= maximum ? maximum : self
    }
}
