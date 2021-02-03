//
//  AlbumDetailViewModel.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import Foundation

class AlbumDetailViewModel {
    
    private let album: Album
    
    var albumName: String {
        album.name
    }
    
    var copyright: String {
        album.copyright
    }
    
    var genres: String {
        album.genres.map { $0.name }.joined(separator: ", ")
    }
    
    var releaseDate: String {
        album.releaseDate
    }
    
    var artist: String {
        album.artist
    }
    
    var itunesUrl: URL {
        album.itunesUrl
    }
    
    var albumImageUrl: URL {
        album.thumbnailUrl
    }
    
    init(album: Album) {
        self.album = album
    }
}
