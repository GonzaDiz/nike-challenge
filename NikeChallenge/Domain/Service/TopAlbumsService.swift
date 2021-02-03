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
        client.execute(request: TopAlbumsRequest(quantity: quantity)) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                let feed = try? jsonDecoder.decode(FeedDTO.self, from: data)
                let albums = feed?.albums.compactMap { mapAlbumDTO($0) } ?? []
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapAlbumDTO(_ dto: AlbumDTO) -> Album {
        return Album(
            name: dto.name,
            artist: dto.artistName,
            thumbnailUrl: dto.thumbnailUrl,
            genres: dto.genres.map { mapGenreDTO($0) },
            releaseDate: dto.releaseDate,
            copyright: dto.copyright,
            itunesUrl: dto.url)
    }
    
    private func mapGenreDTO(_ dto: GenreDTO) -> Genre {
        return Genre(name: dto.name)
    }
}
