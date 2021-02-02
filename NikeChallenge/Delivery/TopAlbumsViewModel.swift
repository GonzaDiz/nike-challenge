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
    var albums: Bindable<[Album]>
    
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
                print("Show Error Screen")
            }
            
        }
    }
}
