//
//  UIImageView+.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import UIKit

extension UIImageView {
    // I know this is not performant, I prefer to use SDWebImage || Kingfisher || Alamofire
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
