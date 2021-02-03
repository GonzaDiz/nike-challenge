//
//  TopAlbumsViewModelTests.swift
//  NikeChallengeTests
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import XCTest
@testable import NikeChallenge

class TopAlbumsViewModelTests: XCTestCase {
    
    var sut: TopAlbumsViewModel!
    var topAlbumsServiceSpy: TopAlbumsServiceSpy!
    var mockedAlbum: Album = Album(
        name: "The Voice (Deluxe)",
        artist: "Lil Durk",
        thumbnailUrl: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Music124/v4/200x200bb.png")!,
        genres: [Genre(name: "Hip-Hop/Rap")],
        releaseDate: "2021-01-29",
        copyright: "℗ 2021 Alamo (Geffen Records)",
        itunesUrl: URL(string: "https://music.apple.com/us/album/the-voice-deluxe/1550392337?app=music")!
    )

    override func setUp() {
        topAlbumsServiceSpy = TopAlbumsServiceSpy()
        sut = TopAlbumsViewModel(topAlbumsService: topAlbumsServiceSpy)
    }
    
    func test_topAlbumsViewModel_shouldCallService_whenViewIsLoaded() {
        sut.viewIsLoaded()
        XCTAssertTrue(topAlbumsServiceSpy.invokedGetTopAlbums)
    }
    
    func test_topAlbumsViewModel_albumsCount_shouldEqual2_whenTopAlbumsServiceFetches2Albums() {
        topAlbumsServiceSpy.stubbedGetTopAlbumsCompletionResult = .some((.success([mockedAlbum, mockedAlbum]), ()))
        sut.viewIsLoaded()
        XCTAssertEqual(sut.albumsCount, 2)
    }
    
    func test_topAlbumsViewModel_shouldHaveAnError_whenTopAlbumsServicesFails() {
        let error = NSError(domain: "Testing", code: 1, userInfo: nil)
        var isErrorMessagePublished = false
        
        topAlbumsServiceSpy.stubbedGetTopAlbumsCompletionResult = .some((.failure(error), ()))
        sut.errorMessage.bind { _ in isErrorMessagePublished = true }
        sut.viewIsLoaded()
        
        XCTAssertTrue(isErrorMessagePublished)
        XCTAssertEqual(sut.errorMessage.value, "Something went wrong")
    }
}

class TopAlbumsServiceSpy: TopAlbumsService {
    var invokedGetTopAlbums = false
    var invokedGetTopAlbumsCount = 0
    var invokedGetTopAlbumsParameters: (quantity: Int, Void)?
    var invokedGetTopAlbumsParametersList = [(quantity: Int, Void)]()
    var stubbedGetTopAlbumsCompletionResult: (Result<[Album], Error>, Void)?

    func getTopAlbums(quantity: Int, completion: @escaping (Result<[Album], Error>) -> Void) {
        invokedGetTopAlbums = true
        invokedGetTopAlbumsCount += 1
        invokedGetTopAlbumsParameters = (quantity, ())
        invokedGetTopAlbumsParametersList.append((quantity, ()))
        if let result = stubbedGetTopAlbumsCompletionResult {
            completion(result.0)
        }
    }
}
