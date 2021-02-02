//
//  TopAlbumsService.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

protocol TopAlbumsService {
    func getTopAlbums(quantity: Int, completion: @escaping (Result<[Album], Error>) -> Void)
}

struct DefaultTopAlbumsService: TopAlbumsService {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
        
    func getTopAlbums(quantity: Int, completion: @escaping (Result<[Album], Error>) -> Void) {
        client.execute(request: TopAlbumsRequest(quantity: quantity)) { (result: Result<FeedDTO?, Error>) in
            switch result {
            case .success(let feed):
                let albums = feed?.albums.compactMap { mapAlbumDTO($0) } ?? []
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapAlbumDTO(_ dto: AlbumDTO) -> Album {
        return Album(
            name: dto.artistName,
            artist: dto.artistName,
            thumbnailUrl: dto.thumbnailUrl)
    }
}
