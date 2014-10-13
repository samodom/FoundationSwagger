//
//  SetTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 9/23/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import XCTest

class SetTests: XCTestCase {

    var stringSet = Set<String>()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testEmptySetHasNoMembers() {
        XCTAssertEqual(stringSet.cardinality, 0, "An empty set should not have any members")
    }

    func testCanAddMemberToSet() {
        stringSet.addMember("sample")
        XCTAssertEqual(stringSet.cardinality, 1, "There should now be one set member")
    }

    func testCanAddMembersToSet() {
        stringSet.addMembers("one", "two", "three")
        XCTAssertEqual(stringSet.cardinality, 3, "There should now be three set members")
    }

    func testCanAddArrayElementsToSet() {
        stringSet.addMembers(fromArray: ["one", "two", "three"])
        XCTAssertEqual(stringSet.cardinality, 3, "There should now be three set members")
    }

    func testCanCreateUnionOfSets() {
        stringSet.addMembers("one", "two", "three")
        var newSet = Set<String>()
        newSet.addMembers("four", "five", "six")
        stringSet.union(newSet)
        XCTAssertEqual(stringSet.cardinality, 6, "There should now be six set members")
    }

    func testIncludedSetMembership() {
        stringSet.addMembers("one", "two")
        XCTAssertTrue(stringSet.isMember("one"), "The members added to the set should be considered members")
        XCTAssertTrue(stringSet.isMember("two"), "The member added to the set should be considered members")
    }

    func testExcludedSetMembership() {
        stringSet.addMembers("one", "two")
        XCTAssertFalse(stringSet.isMember("three"), "The members not added to the set should not be considered members")
    }

    func testDuplicateMembersIgnored() {
        stringSet.addMembers("one", "two", "one")
        XCTAssertEqual(stringSet.cardinality, 2, "There should only be two members in the set")
        XCTAssertTrue(stringSet.isMember("one"), "The member that was added twice should be included in the set")
        XCTAssertTrue(stringSet.isMember("two"), "The member that was added once should be included in the set")
    }

    func testCanCreateSetWithMember() {
        stringSet = Set("sample")
        XCTAssertEqual(stringSet.cardinality, 1, "Should be able to create sets with a single member")
    }

    func testCanCreateSetWithMembers() {
        stringSet = Set("one", "two", "three", "two", "one")
        XCTAssertEqual(stringSet.cardinality, 3, "Should be able to create sets with multiple members and duplicates should be ignored")
        XCTAssertTrue(stringSet.isMember("one"), "Each unique member passed in the constructor should be included in the set")
        XCTAssertTrue(stringSet.isMember("two"), "Each unique member passed in the constructor should be included in the set")
        XCTAssertTrue(stringSet.isMember("three"), "Each unique member passed in the constructor should be included in the set")
    }

    func testCanRemoveMemberFromSet() {
        stringSet.addMembers("one", "two", "three")
        stringSet.removeMember("two")
        XCTAssertEqual(stringSet.cardinality, 2, "There should only be two members remaining in the set")
        XCTAssertTrue(stringSet.isMember("one"), "Members that were not removed should be included in the set")
        XCTAssertFalse(stringSet.isMember("two"), "The member that was removed should not be included in the set")
        XCTAssertTrue(stringSet.isMember("three"), "Members that were not removed should be included in the set")
    }

    func testCanRemoveMembersFromSet() {
        stringSet.addMembers("one", "two", "three")
        stringSet.removeMembers("two", "three")
        XCTAssertEqual(stringSet.cardinality, 1, "There should only be one member remaining in the set")
        XCTAssertTrue(stringSet.isMember("one"), "Members that were not removed should be included in the set")
        XCTAssertFalse(stringSet.isMember("two"), "Members that were removed should not be included in the set")
        XCTAssertFalse(stringSet.isMember("three"), "Members that were removed should not be included in the set")
    }

    func testSetMemberGeneration() {
        stringSet.addMembers("one", "two", "three")
        var memberArray = [String]()
        for member in stringSet {
            memberArray.append(member)
        }
        XCTAssertEqual(memberArray.count, 3, "There should be a total of three members generated")
        XCTAssertTrue(contains(memberArray, "one"), "The first member should be generated")
        XCTAssertTrue(contains(memberArray, "two"), "The second member should be generated")
        XCTAssertTrue(contains(memberArray, "three"), "The third member should be generated")
    }

}
