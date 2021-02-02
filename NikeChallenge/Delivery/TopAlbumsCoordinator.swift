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
        navigationController.pushViewController(viewController, animated: false)
    }
}
