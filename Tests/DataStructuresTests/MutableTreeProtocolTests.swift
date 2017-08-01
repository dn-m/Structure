//
//  ReferenceTreeProtocolTests.swift
//  Structure
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import DataStructures

final class Node: ReferenceTreeProtocol {
    weak var parent: Node?
    var children: [Node] = []
}

class ReferenceTreeProtocolTests: XCTestCase {

    func testAddChild() {
        let parent = Node()
        let child = Node()
        parent.addChild(child)
        XCTAssertEqual(parent.children.count, 1)
        XCTAssert(child.parent! === parent)
    }

    func testAddChildrenVariadic() {
        let parent = Node()
        parent.addChildren([Node(), Node(), Node()])
        XCTAssertEqual(parent.children.count, 3)
    }

    func testAddChildrenArray() {
        let parent = Node()
        parent.addChildren([Node(), Node(), Node()])
        XCTAssertEqual(parent.children.count, 3)
    }

    func testInsertChildAtIndexThrows() {
        let parent = Node()
        let child = Node()
        do {
            try parent.insertChild(child, at: 1)
            XCTFail()
        } catch { }
    }

    func testInsertChildAtIndexValidEmpty() {
        let parent = Node()
        do { try parent.insertChild(Node(), at: 0) }
        catch { XCTFail() }
    }

    func testInsertChildAtIndexValidNotEmpty() {
        let parent = Node()
        parent.addChild(Node())
        do { try parent.insertChild(Node(), at: 0) }
        catch { XCTFail() }
    }

    func testRemoveChildAtIndexThrows() {
        let parent = Node()
        do {
            try parent.removeChild(at: 0)
            XCTFail()
        } catch { }
    }

    func testRemoveChildAtIndexValid() {
        let parent = Node()
        parent.addChild(Node())
        do { try parent.removeChild(at: 0) }
        catch { XCTFail() }

    }

    func testRemoveChildThrows() {
        let parent = Node()
        let child = Node()
        do {
            try parent.removeChild(child)
            XCTFail()
        } catch { }
    }

    func testRemoveChildValid() {
        let parent = Node()
        let child = Node()
        parent.addChild(child)
        do { try parent.removeChild(child) }
        catch { XCTFail() }
    }

    func testHasChildFalseEmpty() {
        let parent = Node()
        XCTAssertFalse(parent.hasChild(Node()))
    }

    func testHasChildFalse() {
        let parent = Node()
        parent.addChild(Node())
        XCTAssertFalse(parent.hasChild(Node()))
    }

    func testHasChildTrue() {
        let parent = Node()
        let child = Node()
        parent.addChild(child)
        XCTAssert(parent.hasChild(child))
    }

    func testChildAtIndexNilEmpty() {
        let parent = Node()
        XCTAssertNil(parent.child(at: 0))
    }

    func testChildAtIndexNil() {
        let parent = Node()
        parent.addChild(Node())
        XCTAssertNil(parent.child(at: 1))
    }

    func testChildAtIndexValidSingle() {
        let parent = Node()
        let child = Node()
        parent.addChild(child)
        XCTAssert(parent.child(at: 0) === child)
    }

    func testChildAtIndexValidMultiple() {
        let parent = Node()
        let child1 = Node()
        let child2 = Node()
        parent.addChild(child1)
        parent.addChild(child2)
        XCTAssert(parent.child(at: 1) === child2)
    }

    func testLeafAtIndexSelf() {
        let leaf = Node()
        XCTAssert(leaf.leaf(at: 0) === leaf)
    }

    func testLeafAtIndexNilLeaf() {
        let leaf = Node()
        XCTAssertNil(leaf.leaf(at: 1))
    }

    func testLeafAtIndexNilSingleDepth() {
        let parent = Node()
        for _ in 0..<5 { parent.addChild(Node()) }
        XCTAssertNil(parent.leaf(at: 5))
    }

    func testLeafAtIndexNilMultipleDepth() {
        let root = Node()
        let internal1 = Node()
        for _ in 0..<2 { internal1.addChild(Node()) }
        let internal2 = Node()
        for _ in 0..<2 { internal2.addChild(Node()) }
        root.addChild(internal1)
        root.addChild(internal2)
        XCTAssertNil(root.leaf(at: 4))
    }

    func testLeafAtIndexValidSingleDepth() {
        let parent = Node()
        let child1 = Node()
        let child2 = Node()
        parent.addChildren([child1, child2])
        XCTAssert(parent.leaf(at: 1) === child2)
    }

    func testLeafAtIndexValidMultipleDepth() {
        let root = Node()
        let internal1 = Node()
        let leaf1 = Node()
        let leaf2 = Node()
        internal1.addChildren([leaf1, leaf2])
        let internal2 = Node()
        let leaf3 = Node()
        let leaf4 = Node()
        internal2.addChildren([leaf3, leaf4])
        root.addChildren([internal1, internal2])
        XCTAssert(root.leaf(at: 3) === leaf4)
    }

    func testIsRootTrueSingleNode() {
        let root = Node()
        XCTAssert(root.isRoot)
    }

    func testIsRootTrueContainer() {
        let root = Node()
        root.addChildren([Node(), Node(), Node()])
        XCTAssert(root.isRoot)
    }

    func testIsLeafTrueRoot() {
        let root = Node()
        XCTAssert(root.isLeaf)
    }

    func testIsLeafTrueLeaf() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssert(child.isLeaf)
    }

    func testIsLeafFalse() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssertFalse(root.isLeaf)
    }

    func testIsContainerTrue() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssert(root.isContainer)
    }

    func testRootSelfSingleNode() {
        let root = Node()
        XCTAssert(root.root === root)
    }

    func testRootOnlyChild() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssert(child.root === root)
    }

    func testRootGrandchild() {
        let root = Node()
        let child = Node()
        let grandchild = Node()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.root === root)
    }

    func testIsContainerFalse() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssertFalse(child.isContainer)
    }

    func testPathToRootSingleNode() {
        let root = Node()
        XCTAssert(root.pathToRoot == [root])
    }

    func testPathToRootOnlyChild() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssert(child.pathToRoot == [child, root])
    }

    func testPathToRootGrandchild() {
        let root = Node()
        let child = Node()
        let grandchild = Node()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.pathToRoot == [grandchild, child, root])
    }

    func testHasAncestorSingleNode() {
        let root = Node()
        XCTAssertFalse(root.hasAncestor(root))
    }

    func testHasAncestorOnlyChild() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssert(child.hasAncestor(root))
    }

    func testHasAncestorGrandchild() {
        let root = Node()
        let child = Node()
        let grandchild = Node()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.hasAncestor(root))
        XCTAssert(child.hasAncestor(root))
    }

    func testAncestorAtDistanceSingleValid() {
        let root = Node()
        XCTAssert(root.ancestor(at: 0) === root)
    }

    func testAncestorAtDistanceSingleNil() {
        let root = Node()
        XCTAssertNil(root.ancestor(at: 1))
    }

    func testAncestorAtDistanceOnlyChild() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssert(child.ancestor(at: 1) === root)
    }

    func testAncestorAtDistanceGrandchild() {
        let root = Node()
        let child = Node()
        let grandchild = Node()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.ancestor(at: 1) === child)
        XCTAssert(grandchild.ancestor(at: 2) === root)
    }

    func testDepthRoot_1() {
        let root = Node()
        XCTAssertEqual(root.depth, 0)
    }

    func testDepthOnlyChild_1() {
        let root = Node()
        let child = Node()
        root.addChild(child)
        XCTAssertEqual(child.depth, 1)
    }

    func testDepthGrandchild_2() {
        let root = Node()
        let child = Node()
        let grandchild = Node()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssertEqual(grandchild.depth, 2)
    }

    func testHeightSingleNode_0() {
        let root = Node()
        XCTAssertEqual(root.height, 0)
    }

    func testHeightParent_1() {
        let parent = Node()
        parent.addChild(Node())
        XCTAssertEqual(parent.height, 1)
    }

    func testHeightGrandparent_2() {
        let grandparent = Node()
        let parent = Node()
        parent.addChild(Node())
        grandparent.addChild(parent)
        XCTAssertEqual(grandparent.height, 2)
        XCTAssertEqual(parent.height, 1)
    }

    func testUnbalancedGrandParent_2() {
        let grandparent = Node()
        let parent1 = Node()
        let parent2 = Node()
        parent1.addChild(Node())
        grandparent.addChild(parent1)
        grandparent.addChild(parent2)
        XCTAssertEqual(grandparent.height, 2)
        XCTAssertEqual(parent2.heightOfTree, 2)
    }

    func testHasDescendentFalseSingleNode() {
        let root = Node()
        let other = Node()
        XCTAssertFalse(root.hasDescendent(other))
    }

    func testHasDescendentParent() {
        let parent = Node()
        let child = Node()
        parent.addChild(child)
        XCTAssert(parent.hasDescendent(child))
        XCTAssertFalse(child.hasDescendent(parent))
    }

    func testHasDescendentGrandparent() {
        let grandparent = Node()
        let parent = Node()
        let child = Node()
        parent.addChild(child)
        grandparent.addChild(parent)
        XCTAssert(grandparent.hasDescendent(child))
        XCTAssertFalse(child.hasDescendent(grandparent))
    }

    func testLeafAtIndexNilNoLeaves() {
        let root = Node()
        XCTAssertNil(root.leaf(at: 2))
    }
}

private func == <T: AnyObject>(lhs: [T], rhs: [T]) -> Bool {
    for (a,b) in zip(lhs, rhs) {
        if a !== b {
            return false
        }
    }
    return true
}
