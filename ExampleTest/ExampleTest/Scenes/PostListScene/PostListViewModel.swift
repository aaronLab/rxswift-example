//
//  PostListViewModel.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import Foundation
import RxSwift
import RxCocoa

class PostListViewModel: BaseService {
    
    private let bag = DisposeBag()
    
    var isLoading = PublishSubject<Bool>()
    var postList = [PostViewModel]()
    var error = PublishSubject<APIError>()
    
    func loadPostList() {
        isLoading.onNext(true)
        
        let maxAttempts = 4
        
        let request = Request<[Post]>(request: getRequest(path: .posts))
        
        URLRequest.load(request: request)
            .retry { e in
                
                e.enumerated()
                    .flatMap { attempt, error -> Observable<Int> in
                        
                        guard let error = error as? APIError else {
                            return Observable.error(APIError.unknown)
                        }
                        
                        if error == APIError.decodingError {
                            return Observable.error(APIError.decodingError)
                        }
                        
                        if attempt >= maxAttempts - 1 {
                            return Observable.error(error)
                        }
                        return Observable<Int>.timer(.seconds(attempt + 1), scheduler: MainScheduler.instance)
                    }
                
            }
            .subscribe(
                onNext: { [weak self] list in
                    self?.postList = list.compactMap(PostViewModel.init)
                    self?.isLoading.onNext(false)
                },
                onError: { [weak self] error in
                    guard let error = error as? APIError else { return }
                    self?.error.onNext(error)
                }
            )
            .disposed(by: bag)
        
    }
    
}

extension PostListViewModel {
    
    func postAt(_ index: Int) -> PostViewModel {
        return postList[index]
    }
    
}

struct PostViewModel {
    
    let post: Post
    
    init(_ post: Post) {
        self.post = post
    }
    
}

extension PostViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(post.title ?? "")
    }
    
    var description: Observable<String> {
        return Observable<String>.just(post.body ?? "")
    }
    
}
