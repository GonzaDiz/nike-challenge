//
//  AlbumDTO.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

struct AlbumDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case artistName
        case thumbnailUrl = "artworkUrl100"
    }
    
    let name: String
    let artistName: String
    let thumbnailUrl: URL
}
