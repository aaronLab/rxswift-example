//
//  PostListViewModel.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import Foundation
import RxSwift
import RxCocoa

class PostListViewModel {

    private let service = PostListService()
    private let bag = DisposeBag()
    
    var isLoading = PublishSubject<Bool>()
    var postList = [PostViewModel]()
    var error = PublishSubject<Error>()

    func loadPostList() {
        isLoading.onNext(true)
        
        service.getPostList()
            .retry(3)
            .subscribe(
            onNext: { [weak self] list in
                self?.postList = list.compactMap(PostViewModel.init)
                self?.isLoading.onNext(false)
            },
            onError: { error in
                self.error.onNext(error)
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
