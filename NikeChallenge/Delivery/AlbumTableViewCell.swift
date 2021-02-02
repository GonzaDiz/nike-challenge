//
//  TopAlbumTableViewCell.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(name: String, artist: String, thumbnailUrl: URL) {
        nameLabel.text = name
        artistLabel.text = artist
        thumbnail.load(url: thumbnailUrl)
    }
    
    private func setUpConstraints() {
        addSubview(nameLabel)
        addSubview(artistLabel)
        addSubview(thumbnail)
        
        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: 90),
            thumbnail.heightAnchor.constraint(equalToConstant: 90),
            thumbnail.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            thumbnail.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        ])
            
    }
}
