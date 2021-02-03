//
//  Client.swift
//  NikeChallenge
//
//  Created by Gonzalo Diz on 01/02/2021.
//

import Foundation

class HTTPClient {
    
    enum HTTPClientError: Swift.Error {
        case couldNotBuildUrlError
        case couldNotRetrieveData
    }
    
    func execute(request: HTTPRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = request.endpoint.url else {
            completion(.failure(HTTPClientError.couldNotBuildUrlError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(HTTPClientError.couldNotRetrieveData))
            }
        }.resume()
    }
}
