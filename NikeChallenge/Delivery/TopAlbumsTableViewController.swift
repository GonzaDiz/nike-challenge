//
//  ViewController.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import UIKit

protocol TopAlbumsViewControllerDelegate: AnyObject {
    func didSelectAlbum(album: Album)
}

final class TopAlbumsTableViewController: UITableViewController {
    
    weak var delegate: TopAlbumsViewControllerDelegate?
    
    private let viewModel: TopAlbumsViewModel
    private let cellIdentifier = "AlbumTableViewCell"
    private let imageLoader = ImageLoader(placeholder: "album-placeholder")

    init(viewModel: TopAlbumsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        title = "Top Albums"
        setupBindings()
        viewModel.viewIsLoaded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albumsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumTableViewCell,
              let album = viewModel.getAlbum(at: indexPath.row) else {
                return UITableViewCell()
            }
        
        imageLoader.load(url: album.thumbnailUrl) { image in
            if let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell {
                cell.updateImage(image: image)
            }
        }
        
        cell.setUp(name: album.name, artist: album.artist)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let album = viewModel.getAlbum(at: indexPath.row) {
            delegate?.didSelectAlbum(album: album)
        }
    }
    
    private func setupBindings() {
        viewModel.albums.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorMessage.bind { [weak self] errorMessage in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
