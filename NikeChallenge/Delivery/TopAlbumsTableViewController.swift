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
    private let imageLoader = ImageLoader(placeholder: "album-placeholder", cacheCountLimit: 20)

    init(viewModel: TopAlbumsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        title = "Top Albums"
        viewModel.albums.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.viewIsLoaded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumTableViewCell else {
                return UITableViewCell()
            }
        
        let album = viewModel.albums.value[indexPath.row]
        imageLoader.load(url: album.thumbnailUrl) { image in
            if let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell {
                cell.updateImage(image: image)
            }
        }
        
        cell.setUp(name: album.name, artist: album.artist)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums.value[indexPath.row]
        delegate?.didSelectAlbum(album: album)
    }
}
