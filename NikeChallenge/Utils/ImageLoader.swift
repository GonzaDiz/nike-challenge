//
//  ImageLoader.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 02/02/2021.
//

import Foundation
import UIKit

// I would prefer to use SDWebImage || Kingfisher || Alamofire.
// TODO: Better cache policy, image compression.
final class ImageLoader {
    
    private var cache: NSCache<NSString, UIImage>
    private var task: URLSessionDownloadTask?
    private let placeholder: String
    
    init(placeholder: String, cacheCountLimit: Int) {
        self.cache = NSCache<NSString, UIImage>()
        cache.countLimit = cacheCountLimit
        self.placeholder = placeholder
    }
    
    func load(url: URL, completion: @escaping (UIImage) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            loadPlaceHolder(completion: completion)
            fetch(from: url, completion: completion)
        }
    }
    
    private func fetch(from url: URL, completion: @escaping (UIImage) -> Void) {
        task = URLSession.shared.downloadTask(with: url) { [weak self] (data, response, error) in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        task?.resume()
    }
    
    private func loadPlaceHolder(completion: @escaping (UIImage) -> Void) {
        if let placeholder = UIImage(named: placeholder) {
            DispatchQueue.main.async {
                completion(placeholder)
            }
        }
    }
    
    deinit {
        task?.cancel()
    }
}
