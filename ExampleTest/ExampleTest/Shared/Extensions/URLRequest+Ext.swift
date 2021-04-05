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

struct Request<T: Decodable> {
    
    let request: URLRequest
    
}

extension URLRequest {

    static func load<T>(request: Request<T>) -> Observable<T> where T: Decodable {

        return Observable.create { observer in

            return URLSession.shared.rx.response(request: request.request)
                .debug("REQUEST LOAD")
                .subscribe(
                onNext: { response in

                    let decoder = JSONDecoder()
                    let decoded = try? decoder.decode(T.self, from: response.data)

                    guard let safeDecoded = decoded else {
                        return observer.onError(APIError.decodingError)
                    }

                    return observer.onNext(safeDecoded)

                },
                onError: { error in
                    observer.onError(error)
                }
            )

        }

    }

}
