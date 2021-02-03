//
//  TopAlbumsViewModel.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

final class TopAlbumsViewModel {
    
    private let topAlbumsQuantity = 100
    
    private let topAlbumsService: TopAlbumsService
    private(set) var albums: Bindable<[Album]>
    private(set) var errorMessage: Bindable<String> = Bindable("")
    
    var albumsCount: Int {
        albums.value.count
    }
    
    init(topAlbumsService: TopAlbumsService) {
        self.topAlbumsService = topAlbumsService
        self.albums = Bindable([])
    }
    
    func viewIsLoaded() {
        topAlbumsService.getTopAlbums(quantity: topAlbumsQuantity) { [weak self] result in
            switch result {
            case .success(let albums):
                self?.albums.value = albums
            case .failure:
                self?.errorMessage.value = "Something went wrong"
            }
        }
    }
    
    func getAlbum(at index: Int) -> Album? {
        albums.value.indices.contains(index) ? albums.value[index] : nil
    }
}
