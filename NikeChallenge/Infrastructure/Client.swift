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
    
    func execute<T: Decodable>(request: HTTPRequest, completion: @escaping (Result<T?, Error>) -> Void) {
        guard let url = request.endpoint.url else {
            completion(.failure(HTTPClientError.couldNotBuildUrlError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let decodedValue = try? jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedValue))
            } else {
                completion(.failure(HTTPClientError.couldNotRetrieveData))
            }
        }.resume()
    }
}
