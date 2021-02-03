//
//  AlbumDetailView.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import UIKit

final class AlbumDetailView: UIView {
    
    private lazy var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var albumName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var copyrightLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    lazy var ctaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open in Music", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        return button
    }()
    
    init(
        albumName: String,
        copyright: String,
        artist: String,
        genres: String,
        releaseDate: String
    ) {
        super.init(frame: .zero)
        setupConstraints()
        self.albumName.text = albumName
        backgroundColor = .systemBackground
        setupArtistLabel(artist: artist)
        setupGenresLabel(genres: genres)
        setupReleaseDateLabel(date: releaseDate)
        setupCtaButton()
        setupCopyrightLabel(copyright: copyright)
        setupAlbumImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(albumImage)
        addSubview(albumName)
                
        NSLayoutConstraint.activate([
            albumName.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 16),
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupAlbumImageView() {        
        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: topAnchor),
            albumImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupArtistLabel(artist: String) {
        addSubview(artistLabel)
        artistLabel.text = artist
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 10),
            artistLabel.leadingAnchor.constraint(equalTo: albumName.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: albumName.trailingAnchor)
        ])
    }
    
    private func setupGenresLabel(genres: String) {
        addSubview(genresLabel)
        genresLabel.text = genres
        
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10),
            genresLabel.leadingAnchor.constraint(equalTo: albumName.leadingAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: albumName.trailingAnchor)
        ])
    }
    
    private func setupReleaseDateLabel(date: String) {
        addSubview(releaseDateLabel)
        releaseDateLabel.text = date
        
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 10),
            releaseDateLabel.leadingAnchor.constraint(equalTo: albumName.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: albumName.trailingAnchor)
        ])
    }
    
    private func setupCopyrightLabel(copyright: String) {
        addSubview(copyrightLabel)

        copyrightLabel.text = copyright

        NSLayoutConstraint.activate([
            copyrightLabel.bottomAnchor.constraint(equalTo: ctaButton.topAnchor, constant: -8),
            copyrightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            copyrightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupCtaButton() {
        addSubview(ctaButton)
        
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ctaButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ctaButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateAlbumImageView(with image: UIImage) {
        albumImage.image = image
    }
}
