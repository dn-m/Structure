//
//  Tree.Zipper.Crumb.swift
//  Tree
//
//  Created by James Bean on 7/28/17.
//

import Destructure

extension Tree.Zipper {

    /// Value of a `Tree` with its neighboring `Tree` values.
    public struct Crumb {

        /// Associated value of the currently in-focus `tree`.
        public let value: Either<Branch,Leaf>

        /// The other trees to the left and right of the tree currently in focus.
        public let trees: ([Tree], [Tree])
    }
}
