//
//  RemoveElements.swift
//  Collections
//
//  Created by James Bean on 12/23/16.
//
//

extension Array {

    // MARK: - Remove Elements

    /**
     Remove first element of Array.

     >`[1,2,3].removeFirst -> [2,3]`

     >`[].removeFirst throws ArrayError.removalError`
     */
    public mutating func removeFirst() throws {

        guard count > 0 else {
            throw ArrayError.removalError
        }

        remove(at: 0)
    }

    /**
     Remove first number of elements from Array.

     >`[1,2,3].removeFirst(amount: 2) -> [1]`

     >`[1,2,3].removeFirst(amount: 4) throws ArrayError.removalError`

     - parameter amount: Amount of elements to remove from beginning of Array
     */
    public mutating func removeFirst(amount: Int) throws {

        guard count >= amount else {
            throw ArrayError.removalError
        }

        for _ in 0..<amount {
            remove(at: 0)
        }
    }

    /**
     Remove last number of elements from Array.

     >`[1,2,3].removeLast(amount: 3) -> []`

     >`[1,2,3].removeLast(amount: 4) throws ArrayError.removalError`

     - parameter amount: Amount of elements to remove from end of Array
     */
    public mutating func removeLast(amount: Int) throws {

        guard count >= amount else {
            throw ArrayError.removalError
        }

        for _ in 0..<amount {
            removeLast()
        }
    }
}
