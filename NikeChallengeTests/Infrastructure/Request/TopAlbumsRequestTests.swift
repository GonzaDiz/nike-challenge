//
//  TopAlbumsRequestTests.swift
//  NikeChallengeTests
//
//  Created by Gonzalo Diz on 03/02/2021.
//

import XCTest
@testable import NikeChallenge

class TopAlbumsRequestTests: XCTestCase {

    func test_topAlbumsRequest_path_shouldEqualValidPath() {
        let request = TopAlbumsRequest(quantity: 100)
        XCTAssertEqual(request.endpoint.path, "/api/v1/us/apple-music/top-albums/all/100/explicit.json")
    }
}
