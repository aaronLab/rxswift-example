//
//  URLRequest+Ext.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import Foundation
import RxSwift
import RxCocoa

enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case del = "DELETE"
    case put = "PUT"
    case patch = "PATCH"

}

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}

extension APIError: Equatable {
    
}

extension APIError {
    
    var msg: String {
        switch self {
        case .decodingError:
            return "Decoding error occured"
        case .httpError(let statusCode):
            return "Network error occured: \(statusCode) "
        case .unknown:
            return "Unknown error occured"
        }
    }
    
}

struct Request<T: Decodable> {
    
    let request: URLRequest
    
}

extension URLRequest {

    static func load<T>(request: Request<T>) -> Observable<T> where T: Decodable {

        return Observable.create { observer in

            return URLSession.shared.rx.response(request: request.request)
                .debug("REQUEST LOAD")
                .subscribe(
                onNext: { response, data in
                    
                    if (200..<300).contains(response.statusCode) {
                        
                        let decoder = JSONDecoder()
                        let decoded = try? decoder.decode(T.self, from: data)

                        guard let safeDecoded = decoded else {
                            return observer.onError(APIError.decodingError)
                        }

                        return observer.onNext(safeDecoded)
                        
                    } else {
                        
                        return observer.onError(APIError.httpError(response.statusCode))
                        
                    }

                },
                onError: { error in
                    observer.onError(error)
                }
            )

        }

    }

}
