//
//  Unzip.swift
//  Algorithms
//
//  Created by James Bean on 8/25/18.
//

extension Sequence {

    public func unzipped <K,V>() -> ([K],[V]) where Element == (K,V) {
//        var xs: [K] = []
//        var ys: [V] = []
//        forEach { (x,y) in
//            xs.append(x)
//            ys.append(y)
//        }
//        return (xs,ys)

        // Same as imperative
//        let result: ([K],[V]) = ([],[])
//        return reduce(into: result) { accum, cur in
//            accum.0.append(cur.0)
//            accum.1.append(cur.1)
//        }

//        fatalError()
        // Double map is faster than appending (without reserving capacity)
        return (map { $0.0 }, map { $0.1 })
    }
}

//extension Collection {
//
//    public func unzipped <K,V>() -> ([K],[V]) where Element == (K,V) {
////        var xs: [K] = []
////        var ys: [V] = []
////        xs.reserveCapacity(count)
////        ys.reserveCapacity(count)
////        forEach { (x,y) in
////            xs.append(x)
////            ys.append(y)
////        }
////        return (xs,ys)
//
////        var result: ([K],[V]) = ([],[])
////        result.0.reserveCapacity(count)
////        result.1.reserveCapacity(count)
////        return reduce(into: result) { accum, cur in
////            accum.0.append(cur.0)
////            accum.1.append(cur.1)
////        }
//
//        return (map { $0.0 }, map { $0.1 })
//    }
//}
