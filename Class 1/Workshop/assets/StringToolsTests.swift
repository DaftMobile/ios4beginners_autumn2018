/*
* StringToolsTests.swift
* Created by Kajetan Dąbrowski on 12/11/2018.
*
* iOS 4 Beginners 2018
* Copyright 2018 DaftMobile Sp. z o. o.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or  * implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import XCTest
@testable import HelloSwift

class StringToolsTests: XCTestCase {

	var stringTools: StringTools!

	override func setUp() {
		super.setUp()
		stringTools = StringTools()
	}

	override func tearDown() {
		stringTools = nil
		super.tearDown()
	}

	func testOccurencesFromEmptyString() {
		XCTAssertEqual(stringTools.countOccurences(character: "x", from: ""), 0)
	}

	func testLongString() {
		XCTAssertEqual(stringTools.countOccurences(character: "r", from: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."), 22)
	}

	func testCorrectlyUsesCaseSensitive1() {
		XCTAssertEqual(stringTools.countOccurences(character: "x", from: "xXX"), 1)
	}

	func testCorrectlyUsesCaseSensitive2() {
		XCTAssertEqual(stringTools.countOccurences(character: "x", from: "xXX", caseSensitive: true), 1)
	}

	func testCorrectlyUsesCaseSensitive3() {
		XCTAssertEqual(stringTools.countOccurences(character: "x", from: "xXX", caseSensitive: false), 3)
	}

	func testCorrectlySearchesForEmoji1() {
		XCTAssertEqual(stringTools.countOccurences(character: "🙈", from: "🙉🙉🙉🏃‍♀️"), 0)
	}

	func testCorrectlySearchesForEmoji2() {
		XCTAssertEqual(stringTools.countOccurences(character: "🙈", from: "🙉🙈🙉🙉🏃‍♀️"), 1)
	}

	func testCorrectlySearchesForEmoji3() {
		XCTAssertEqual(stringTools.countOccurences(character: "🙈", from: "🙉🙉🙉🏃‍♀️", caseSensitive: false), 0)
	}

	func testCorrectlySearchesForEmoji4() {
		XCTAssertEqual(stringTools.countOccurences(character: "🙈", from: "🙉🙈🙉🙉🏃‍♀️", caseSensitive: false), 1)
	}

	func testCorrectlySearchesRegexSpecialCharacters1() {
		XCTAssertEqual(stringTools.countOccurences(character: "?", from: "Hello. How are you? I'm quite fine thanks."), 1)
	}

	func testCorrectlySearchesRegexSpecialCharacters2() {
		XCTAssertEqual(stringTools.countOccurences(character: ".", from: "Hello. How are you? I'm quite fine thanks."), 2)
	}
}
