//
//  FeedDTO.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

struct FeedDTO: Decodable {
    enum CodingKeys: CodingKey {
        case feed
    }
    
    enum AlbumCodingKey: String, CodingKey {
        case albums = "results"
    }
    
    let albums: [AlbumDTO]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: AlbumCodingKey.self, forKey: .feed)
        albums = try nestedContainer.decode([AlbumDTO].self, forKey: .albums)
    }
}
