//
//  AlbumDetailViewController.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import UIKit

final class AlbumDetailViewController: UIViewController {
    
    private let viewModel: AlbumDetailViewModel
    
    private lazy var albumDetailView: AlbumDetailView = {
        AlbumDetailView()
    }()
    
    init(viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = albumDetailView
    }
}
