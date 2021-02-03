//
//  TopAlbumsCoordinator.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import UIKit

protocol Coordinator {
    func start()
}

final class TopAlbumsCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = DefaultTopAlbumsService(client: HTTPClient())
        let viewModel = TopAlbumsViewModel(topAlbumsService: service)
        let viewController = TopAlbumsTableViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToAlbumDetail(album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        let viewController = AlbumDetailViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - TopAlbumsViewControllerDelegate

extension TopAlbumsCoordinator: TopAlbumsViewControllerDelegate {
    func didSelectAlbum(album: Album) {
        goToAlbumDetail(album: album)
    }
}

// MARK: - AlbumDetailViewControllerDelegate

extension TopAlbumsCoordinator: AlbumDetailViewControllerDelegate {
    func didTapMusicButton(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
