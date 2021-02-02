//
//  TopAlbumsRequest.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

struct TopAlbumsRequest: HTTPRequest {
    
    private struct Constants {
        static let host = "rss.itunes.apple.com"
        static let scheme = "https"
        static let path = "/api/v1/us/apple-music/top-albums/all/$/explicit.json"
    }
    
    let method: HTTPMethod = .GET
    let endpoint: Endpoint

    init(quantity: Int) {
        let path = String(format: Constants.path, quantity)

        endpoint = Endpoint(
            path: path,
            host: Constants.host,
            scheme: Constants.scheme
        )
    }
}
