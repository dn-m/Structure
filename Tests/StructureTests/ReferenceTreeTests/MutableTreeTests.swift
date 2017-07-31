//
//  ReferenceTreeTests.swift
//  Structure
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import Structure

class ReferenceTreeTests: XCTestCase {

    func testAddChild() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        parent.addChild(child)
        XCTAssertEqual(parent.children.count, 1)
        XCTAssert(child.parent! === parent)
    }

    func testAddChildrenVariadic() {
        let parent = ReferenceTree()
        parent.addChildren([ReferenceTree(), ReferenceTree(), ReferenceTree()])
        XCTAssertEqual(parent.children.count, 3)
    }

    func testAddChildrenArray() {
        let parent = ReferenceTree()
        parent.addChildren([ReferenceTree(), ReferenceTree(), ReferenceTree()])
        XCTAssertEqual(parent.children.count, 3)
    }

    func testInsertChildAtIndexThrows() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        do {
            try parent.insertChild(child, at: 1)
            XCTFail()
        } catch { }
    }

    func testInsertChildAtIndexValidEmpty() {
        let parent = ReferenceTree()
        do { try parent.insertChild(ReferenceTree(), at: 0) }
        catch { XCTFail() }
    }

    func testInsertChildAtIndexValidNotEmpty() {
        let parent = ReferenceTree()
        parent.addChild(ReferenceTree())
        do { try parent.insertChild(ReferenceTree(), at: 0) }
        catch { XCTFail() }
    }

    func testRemoveChildAtIndexThrows() {
        let parent = ReferenceTree()
        do {
            try parent.removeChild(at: 0)
            XCTFail()
        } catch { }
    }

    func testRemoveChildAtIndexValid() {
        let parent = ReferenceTree()
        parent.addChild(ReferenceTree())
        do { try parent.removeChild(at: 0) }
        catch { XCTFail() }

    }

    func testRemoveChildThrows() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        do {
            try parent.removeChild(child)
            XCTFail()
        } catch { }
    }

    func testRemoveChildValid() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        parent.addChild(child)
        do { try parent.removeChild(child) }
        catch { XCTFail() }
    }

    func testHasChildFalseEmpty() {
        let parent = ReferenceTree()
        XCTAssertFalse(parent.hasChild(ReferenceTree()))
    }

    func testHasChildFalse() {
        let parent = ReferenceTree()
        parent.addChild(ReferenceTree())
        XCTAssertFalse(parent.hasChild(ReferenceTree()))
    }

    func testHasChildTrue() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        parent.addChild(child)
        XCTAssert(parent.hasChild(child))
    }

    func testChildAtIndexNilEmpty() {
        let parent = ReferenceTree()
        XCTAssertNil(parent.child(at: 0))
    }

    func testChildAtIndexNil() {
        let parent = ReferenceTree()
        parent.addChild(ReferenceTree())
        XCTAssertNil(parent.child(at: 1))
    }

    func testChildAtIndexValidSingle() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        parent.addChild(child)
        XCTAssert(parent.child(at: 0) === child)
    }

    func testChildAtIndexValidMultiple() {
        let parent = ReferenceTree()
        let child1 = ReferenceTree()
        let child2 = ReferenceTree()
        parent.addChild(child1)
        parent.addChild(child2)
        XCTAssert(parent.child(at: 1) === child2)
    }

    func testLeafAtIndexSelf() {
        let leaf = ReferenceTree()
        XCTAssert(leaf.leaf(at: 0) === leaf)
    }

    func testLeafAtIndexNilLeaf() {
        let leaf = ReferenceTree()
        XCTAssertNil(leaf.leaf(at: 1))
    }

    func testLeafAtIndexNilSingleDepth() {
        let parent = ReferenceTree()
        for _ in 0..<5 { parent.addChild(ReferenceTree()) }
        XCTAssertNil(parent.leaf(at: 5))
    }

    func testLeafAtIndexNilMultipleDepth() {
        let root = ReferenceTree()
        let internal1 = ReferenceTree()
        for _ in 0..<2 { internal1.addChild(ReferenceTree()) }
        let internal2 = ReferenceTree()
        for _ in 0..<2 { internal2.addChild(ReferenceTree()) }
        root.addChild(internal1)
        root.addChild(internal2)
        XCTAssertNil(root.leaf(at: 4))
    }

    func testLeafAtIndexValidSingleDepth() {
        let parent = ReferenceTree()
        let child1 = ReferenceTree()
        let child2 = ReferenceTree()
        parent.addChildren([child1, child2])
        XCTAssert(parent.leaf(at: 1) === child2)
    }

    func testLeafAtIndexValidMultipleDepth() {
        let root = ReferenceTree()
        let internal1 = ReferenceTree()
        let leaf1 = ReferenceTree()
        let leaf2 = ReferenceTree()
        internal1.addChildren([leaf1, leaf2])
        let internal2 = ReferenceTree()
        let leaf3 = ReferenceTree()
        let leaf4 = ReferenceTree()
        internal2.addChildren([leaf3, leaf4])
        root.addChildren([internal1, internal2])
        XCTAssert(root.leaf(at: 3) === leaf4)
    }

    func testIsRootTrueSingleNode() {
        let root = ReferenceTree()
        XCTAssert(root.isRoot)
    }

    func testIsRootTrueContainer() {
        let root = ReferenceTree()
        root.addChildren([ReferenceTree(), ReferenceTree(), ReferenceTree()])
        XCTAssert(root.isRoot)
    }

    func testIsLeafTrueRoot() {
        let root = ReferenceTree()
        XCTAssert(root.isLeaf)
    }

    func testIsLeafTrueLeaf() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssert(child.isLeaf)
    }

    func testIsLeafFalse() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssertFalse(root.isLeaf)
    }

    func testIsContainerTrue() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssert(root.isContainer)
    }

    func testRootSelfSingleNode() {
        let root = ReferenceTree()
        XCTAssert(root.root === root)
    }

    func testRootOnlyChild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssert(child.root === root)
    }

    func testRootGrandchild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        let grandchild = ReferenceTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.root === root)
    }

    func testIsContainerFalse() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssertFalse(child.isContainer)
    }

    func testPathToRootSingleNode() {
        let root = ReferenceTree()
        XCTAssert(root.pathToRoot == [root])
    }

    func testPathToRootOnlyChild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssert(child.pathToRoot == [child, root])
    }

    func testPathToRootGrandchild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        let grandchild = ReferenceTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.pathToRoot == [grandchild, child, root])
    }

    func testHasAncestorSingleNode() {
        let root = ReferenceTree()
        XCTAssertFalse(root.hasAncestor(root))
    }

    func testHasAncestorOnlyChild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssert(child.hasAncestor(root))
    }

    func testHasAncestorGrandchild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        let grandchild = ReferenceTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.hasAncestor(root))
        XCTAssert(child.hasAncestor(root))
    }

    func testAncestorAtDistanceSingleValid() {
        let root = ReferenceTree()
        XCTAssert(root.ancestor(at: 0) === root)
    }

    func testAncestorAtDistanceSingleNil() {
        let root = ReferenceTree()
        XCTAssertNil(root.ancestor(at: 1))
    }

    func testAncestorAtDistanceOnlyChild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssert(child.ancestor(at: 1) === root)
    }

    func testAncestorAtDistanceGrandchild() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        let grandchild = ReferenceTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssert(grandchild.ancestor(at: 1) === child)
        XCTAssert(grandchild.ancestor(at: 2) === root)
    }

    func testDepthRoot_1() {
        let root = ReferenceTree()
        XCTAssertEqual(root.depth, 0)
    }

    func testDepthOnlyChild_1() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        root.addChild(child)
        XCTAssertEqual(child.depth, 1)
    }

    func testDepthGrandchild_2() {
        let root = ReferenceTree()
        let child = ReferenceTree()
        let grandchild = ReferenceTree()
        child.addChild(grandchild)
        root.addChild(child)
        XCTAssertEqual(grandchild.depth, 2)
    }

    func testHeightSingleNode_0() {
        let root = ReferenceTree()
        XCTAssertEqual(root.height, 0)
    }

    func testHeightParent_1() {
        let parent = ReferenceTree()
        parent.addChild(ReferenceTree())
        XCTAssertEqual(parent.height, 1)
    }

    func testHeightGrandparent_2() {
        let grandparent = ReferenceTree()
        let parent = ReferenceTree()
        parent.addChild(ReferenceTree())
        grandparent.addChild(parent)
        XCTAssertEqual(grandparent.height, 2)
        XCTAssertEqual(parent.height, 1)
    }

    func testUnbalancedGrandParent_2() {
        let grandparent = ReferenceTree()
        let parent1 = ReferenceTree()
        let parent2 = ReferenceTree()
        parent1.addChild(ReferenceTree())
        grandparent.addChild(parent1)
        grandparent.addChild(parent2)
        XCTAssertEqual(grandparent.height, 2)
        XCTAssertEqual(parent2.heightOfTree, 2)
    }

    func testHasDescendentFalseSingleNode() {
        let root = ReferenceTree()
        let other = ReferenceTree()
        XCTAssertFalse(root.hasDescendent(other))
    }

    func testHasDescendentParent() {
        let parent = ReferenceTree()
        let child = ReferenceTree()
        parent.addChild(child)
        XCTAssert(parent.hasDescendent(child))
        XCTAssertFalse(child.hasDescendent(parent))
    }

    func testHasDescendentGrandparent() {
        let grandparent = ReferenceTree()
        let parent = ReferenceTree()
        let child = ReferenceTree()
        parent.addChild(child)
        grandparent.addChild(parent)
        XCTAssert(grandparent.hasDescendent(child))
        XCTAssertFalse(child.hasDescendent(grandparent))
    }

    func testLeafAtIndexNilNoLeaves() {
        let root = ReferenceTree()
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
