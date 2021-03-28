//
//  URLSession+Ext.swift
//  OTPTest
//
//  Created by Aaron Lee on 2021/03/28.
//

import Foundation
import RxSwift
import RxCocoa

struct Request<T: Decodable>{
    
    let url: URL
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension URLSession {
    
    static func load<T, B>(request: Request<T>,
                           httpMethod: HTTPMethod,
                           headers: [String: String]? = nil,
                           body: B? = nil) -> Observable<T> where B: Encodable {
        
        return Observable.just(request.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                
                var request = URLRequest(url: url)
                request.httpMethod = httpMethod.rawValue
                
                if let headers = headers {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    for (key, value) in headers {
                        request.setValue(value, forHTTPHeaderField: key)
                    }
                }
                
                if let body = body {
                    let encoder = JSONEncoder()
                    encoder.keyEncodingStrategy = .convertToSnakeCase
                    
                    let bodyData = try? encoder.encode(body)
                    request.httpBody = bodyData
                }
                
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> T in
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
                
            }.asObservable()
        
    }
    
}
