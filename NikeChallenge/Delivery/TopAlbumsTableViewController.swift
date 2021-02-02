//
//  ViewController.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import UIKit

final class TopAlbumsTableViewController: UITableViewController {
    
    private let viewModel: TopAlbumsViewModel

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
        viewModel.albums.bind { albums in
            
        }
        viewModel.viewIsLoaded()
    }
}
