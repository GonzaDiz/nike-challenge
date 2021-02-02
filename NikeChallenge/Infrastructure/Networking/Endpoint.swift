//
//  Endpoint.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

struct Endpoint {
    let path: String
    let host: String
    let scheme: String
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        return urlComponents.url
    }
}
