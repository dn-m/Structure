//
//  MutableTreeTests.swift
//  Structure
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import Structure

class MutableTreeTests: XCTestCase {

    func testAddChild() {
        let parent = MutableTree()
        let child = MutableTree()
        parent.addChild(child)
        XCTAssertEqual(parent.children.count, 1)
        XCTAssert(child.parent! === parent)
    }

    func testAddChildrenVariadic() {
        let parent = MutableTree()
        parent.addChildren([MutableTree(), MutableTree(), MutableTree()])
        XCTAssertEqual(parent.children.count, 3)
    }

    func testAddChildrenArray() {
        let parent = MutableTree()
        parent.addChildren([MutableTree(), MutableTree(), MutableTree()])
        XCTAssertEqual(parent.children.count, 3)
    }

    func testInsertChildAtIndexThrows() {
        let parent = MutableTree()
        let child = MutableTree()
        do {
            try parent.insertChild(child, at: 1)
            XCTFail()
        } catch { }
    }

    func testInsertChildAtIndexValidEmpty() {
        let parent = MutableTree()
        do { try parent.insertChild(MutableTree(), at: 0) }
        catch { XCTFail() }
    }

    func testInsertChildAtIndexValidNotEmpty() {
        let parent = MutableTree()
        parent.addChild(MutableTree())
        do { try parent.insertChild(MutableTree(), at: 0) }
        catch { XCTFail() }
    }

    func testRemoveChildAtIndexThrows() {
        let parent = MutableTree()
        do {
            try parent.removeChild(at: 0)
            XCTFail()
        } catch { }
    }

    func testRemoveChildAtIndexValid() {
        let parent = MutableTree()
        parent.addChild(MutableTree())
        do { try parent.removeChild(at: 0) }
        catch { XCTFail() }

    }

    func testRemoveChildThrows() {
        let parent = MutableTree()
        let child = MutableTree()
        do {
            try parent.removeChild(child)
            XCTFail()
        } catch { }
    }

    func testRemoveChildValid() {
        let parent = MutableTree()
        let child = MutableTree()
        parent.addChild(child)
        do { try parent.removeChild(child) }
        catch { XCTFail() }
    }

    func testHasChildFalseEmpty() {
        let parent = MutableTree()
        XCTAssertFalse(parent.hasChild(MutableTree()))
    }

    func testHasChildFalse() {
        let parent = MutableTree()
        parent.addChild(MutableTree())
        XCTAssertFalse(parent.hasChild(MutableTree()))
    }

    func testHasChildTrue() {
        let parent = MutableTree()
        let child = MutableTree()
        parent.addChild(child)
        XCTAssert(parent.hasChild(child))
    }

    func testChildAtIndexNilEmpty() {
        let parent = MutableTree()
        XCTAssertNil(parent.child(at: 0))
    }

    func testChildAtIndexNil() {
        let parent = MutableTree()
        parent.addChild(MutableTree())
        XCTAssertNil(parent.child(at: 1))
    }

    func testChildAtIndexValidSingle() {
        let parent = MutableTree()
        let child = MutableTree()
        parent.addChild(child)
        XCTAssert(parent.child(at: 0) === child)
    }

    func testChildAtIndexValidMultiple() {
        let parent = MutableTree()
        let child1 = MutableTree()
        let child2 = MutableTree()
        parent.addChild(child1)
        parent.addChild(child2)
        XCTAssert(parent.child(at: 1) === child2)
    }

    func testLeafAtIndexSelf() {
        let leaf = MutableTree()
        XCTAssert(leaf.leaf(at: 0) === leaf)
    }

    func testLeafAtIndexNilLeaf() {
        let leaf = MutableTree()
        XCTAssertNil(leaf.leaf(at: 1))
    }

    func testLeafAtIndexNilSingleDepth() {
        let parent = MutableTree()
        for _ in 0..<5 { parent.addChild(MutableTree()) }
        XCTAssertNil(parent.leaf(at: 5))
    }

    func testLeafAtIndexNilMultipleDepth() {
        let root = MutableTree()
        let internal1 = MutableTree()
        for _ in 0..<2 { internal1.addChild(MutableTree()) }
        let internal2 = MutableTree()
        for _ in 0..<2 { internal2.addChild(MutableTree()) }
        root.addChild(internal1)
        root.addChild(internal2)
        XCTAssertNil(root.leaf(at: 4))
    }

    func testLeafAtIndexValidSingleDepth() {
        let parent = MutableTree()
        let child1 = MutableTree()
        let child2 = MutableTree()
        parent.addChildren([child1, child2])
        XCTAssert(parent.leaf(at: 1) === child2)
    }

    func testLeafAtIndexValidMultipleDepth() {
        let root = MutableTree()
        let internal1 = MutableTree()
        let leaf1 = MutableTree()
        let leaf2 = MutableTree()
        internal1.addChildren([leaf1, leaf2])
        let internal2 = MutableTree()
        let leaf3 = MutableTree()
        let leaf4 = MutableTree()
        internal2.addChildren([leaf3, leaf4])
        root.addChildren([internal1, internal2])
        XCTAssert(root.leaf(at: 3) === leaf4)
    }

    func testIsRootTrueSingleNode() {
        let root = MutableTree()
        XCTAssert(root.isRoot)
    }

    func testIsRootTrueContainer() {
        let root = MutableTree()
        root.addChildren([MutableTree(), MutableTree(), MutableTree()])
        XCTAssert(root.isRoot)
    }

    func testIsLeafTrueRoot() {
        let root = MutableTree()
        XCTAssert(root.isLeaf)
    }

    func testIsLeafTrueLeaf() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssert(child.isLeaf)
    }

    func testIsLeafFalse() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssertFalse(root.isLeaf)
    }

    func testIsContainerTrue() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssert(root.isContainer)
    }

    func testRootSelfSingleNode() {
        let root = MutableTree()
        XCTAssert(root.root === root)
    }

    func testRootOnlyChild() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssert(child.root === root)
    }

    func testRootGrandchild() {
        let root = MutableTree()
        let child = MutableTree()
        let grandchild = MutableTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.root === root)
    }

    func testIsContainerFalse() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssertFalse(child.isContainer)
    }

    func testPathToRootSingleNode() {
        let root = MutableTree()
        XCTAssert(root.pathToRoot == [root])
    }

    func testPathToRootOnlyChild() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssert(child.pathToRoot == [child, root])
    }

    func testPathToRootGrandchild() {
        let root = MutableTree()
        let child = MutableTree()
        let grandchild = MutableTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.pathToRoot == [grandchild, child, root])
    }

    func testHasAncestorSingleNode() {
        let root = MutableTree()
        XCTAssertFalse(root.hasAncestor(root))
    }

    func testHasAncestorOnlyChild() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssert(child.hasAncestor(root))
    }

    func testHasAncestorGrandchild() {
        let root = MutableTree()
        let child = MutableTree()
        let grandchild = MutableTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.hasAncestor(root))
        XCTAssert(child.hasAncestor(root))
    }

    func testAncestorAtDistanceSingleValid() {
        let root = MutableTree()
        XCTAssert(root.ancestor(at: 0) === root)
    }

    func testAncestorAtDistanceSingleNil() {
        let root = MutableTree()
        XCTAssertNil(root.ancestor(at: 1))
    }

    func testAncestorAtDistanceOnlyChild() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssert(child.ancestor(at: 1) === root)
    }

    func testAncestorAtDistanceGrandchild() {
        let root = MutableTree()
        let child = MutableTree()
        let grandchild = MutableTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.ancestor(at: 1) === child)
        XCTAssert(grandchild.ancestor(at: 2) === root)
    }

    func testDepthRoot_1() {
        let root = MutableTree()
        XCTAssertEqual(root.depth, 0)
    }

    func testDepthOnlyChild_1() {
        let root = MutableTree()
        let child = MutableTree()
        root.addChild(child)
        XCTAssertEqual(child.depth, 1)
    }

    func testDepthGrandchild_2() {
        let root = MutableTree()
        let child = MutableTree()
        let grandchild = MutableTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssertEqual(grandchild.depth, 2)
    }

    func testHeightSingleNode_0() {
        let root = MutableTree()
        XCTAssertEqual(root.height, 0)
    }

    func testHeightParent_1() {
        let parent = MutableTree()
        parent.addChild(MutableTree())
        XCTAssertEqual(parent.height, 1)
    }

    func testHeightGrandparent_2() {
        let grandparent = MutableTree()
        let parent = MutableTree()
        parent.addChild(MutableTree())
        grandparent.addChild(parent)
        XCTAssertEqual(grandparent.height, 2)
        XCTAssertEqual(parent.height, 1)
    }

    func testUnbalancedGrandParent_2() {
        let grandparent = MutableTree()
        let parent1 = MutableTree()
        let parent2 = MutableTree()
        parent1.addChild(MutableTree())
        grandparent.addChild(parent1)
        grandparent.addChild(parent2)
        XCTAssertEqual(grandparent.height, 2)
        XCTAssertEqual(parent2.heightOfTree, 2)
    }

    func testHasDescendentFalseSingleNode() {
        let root = MutableTree()
        let other = MutableTree()
        XCTAssertFalse(root.hasDescendent(other))
    }

    func testHasDescendentParent() {
        let parent = MutableTree()
        let child = MutableTree()
        parent.addChild(child)
        XCTAssert(parent.hasDescendent(child))
        XCTAssertFalse(child.hasDescendent(parent))
    }

    func testHasDescendentGrandparent() {
        let grandparent = MutableTree()
        let parent = MutableTree()
        let child = MutableTree()
        parent.addChild(child)
        grandparent.addChild(parent)
        XCTAssert(grandparent.hasDescendent(child))
        XCTAssertFalse(child.hasDescendent(grandparent))
    }

    func testLeafAtIndexNilNoLeaves() {
        let root = MutableTree()
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
