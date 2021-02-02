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
    var albums: Dynamic<[Album]>
    
    init(topAlbumsService: TopAlbumsService) {
        self.topAlbumsService = topAlbumsService
        self.albums = Dynamic([])
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

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ varible: T) {
        value = varible
    }
}
