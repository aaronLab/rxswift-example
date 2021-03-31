import Foundation
import RxSwift

enum MyError: Error {
    case myError
}

let observable1 = Observable.of("A", "B", "C")

let subscription = observable1.subscribe { event in
    print(event)
}

subscription.dispose()

let bag = DisposeBag()

Observable.of("D", "E", "F")
    .subscribe {
        print($0)
    }
    .disposed(by: bag)

Observable<String>.create { observer in
    
    observer.onNext("1")
    
    observer.onError(MyError.myError)
    
    observer.onCompleted()
    
    observer.onNext("?")
    
    return Disposables.create()
    
}.subscribe(
    onNext: { print($0) },
    onError: { print($0) },
    onCompleted: { print("completed") },
    onDisposed: { print("disposed") }
)
.disposed(by: bag) // => commented onError, conCompleted, and this => memory leak
