//
//  AlbumDetailViewController.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import UIKit

protocol AlbumDetailViewControllerDelegate: AnyObject {
    func didTapMusicButton(url: URL)
}

final class AlbumDetailViewController: UIViewController {
    
    weak var delegate: AlbumDetailViewControllerDelegate?
    
    private let viewModel: AlbumDetailViewModel
    private let imageLoader: ImageLoader = ImageLoader(
        placeholder: "album-placeholder"
    )
    
    private lazy var albumDetailView: AlbumDetailView = {
        let view = AlbumDetailView(
            albumName: viewModel.albumName,
            copyright: viewModel.copyright,
            artist: viewModel.artist,
            genres: viewModel.genres,
            releaseDate: viewModel.releaseDate
        )
        return view
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
        
        imageLoader.load(url: viewModel.albumImageUrl) { [weak self] image in
            self?.albumDetailView.updateAlbumImageView(with: image)
        }
        
        albumDetailView.ctaButton.addTarget(
            self,
            action: #selector(didTapMusicButton),
            for: .touchUpInside
        )
    }
    
    @objc
    func didTapMusicButton() {
        delegate?.didTapMusicButton(url: viewModel.itunesUrl)
    }
}
