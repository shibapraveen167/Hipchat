//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import XCTest

class StringExtensionsTests: XCTestCase {

    // MARK: Emoticon filter tests

    func testEmoticonsFilter() {
        let testEmoticonsString = "Testing emoticons (smiley) in the text"
        XCTAssertEqual("smiley", testEmoticonsString.filterEmoticons().first)
    }

    func testEmoticonsFilterForMaxLength() {
        // Emoticons should be no longer than 15 characters, contained in parenthesis
        let testEmoticonsString = "Testing emoticons (abcdefghijklmnopq) in the text"
        XCTAssertEqual([], testEmoticonsString.filterEmoticons())
    }

    func testEmoticonsFilterForNonAlphaNumeric() {
        let testEmoticonsString = "Testing emoticons (smiley:P) in the text"
        XCTAssertEqual([], testEmoticonsString.filterEmoticons())
    }

    // MARK: Mentions filter tests

    func testMentionsFilter() {
        let testMentionsString = "Testing mentions @Shiba in the text"
        XCTAssertEqual("Shiba", testMentionsString.filterMentions().first)
    }

    // MARK: Links filter tests

    func testLinksFilter() {
        let testLinkString = "Testing twitter link https://twitter.com/jdorfman/status/430511497475670016"
        XCTAssertEqual("https://twitter.com/jdorfman/status/430511497475670016", testLinkString.filterLinks().first)
    }
}
