//
//  PostListService.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import Foundation
import RxSwift

struct PostListService: BaseModel {
    
    func getPostList() -> Observable<[Post]> {
        
        let request = Request<[Post]>(request: getRequest(path: "/post"))
        
        return URLRequest.load(request: request)
        
    }
    
}
