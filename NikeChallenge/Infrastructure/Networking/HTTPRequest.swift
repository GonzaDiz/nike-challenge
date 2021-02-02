//
//  HTTPRequest.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

protocol HTTPRequest {
    var method: HTTPMethod { get }
    var endpoint: Endpoint { get }
}

enum HTTPMethod: String {
    case GET
}
