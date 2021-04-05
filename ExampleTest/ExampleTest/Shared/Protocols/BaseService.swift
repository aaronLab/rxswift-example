//
//  BaseModel.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import Foundation

enum Endpoint: String {
    case posts = "/posts"
}

class BaseService {

    private func getURL(path: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.scheme = "HTTPS"
        if let path = path {
            urlComponents.path = path
        }

        return urlComponents.url
    }
    
    func getRequest(path: Endpoint?,
        method: HTTPMethod = .get,
        headers: [String: String] = [:]) -> URLRequest {

        guard let url = getURL(path: path?.rawValue) else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request

    }

    func getRequest<T: Encodable>(path: Endpoint?,
        method: HTTPMethod,
        headers: [String: String] = [:],
        body: T? = nil) -> URLRequest {

        guard let url = getURL(path: path?.rawValue) else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONEncoder().encode(body)
        
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request

    }

}
