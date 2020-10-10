import UIKit
import RxSwift

//let observable = Observable.just(1)  // <Int>
//
//let observable2 = Observable.of(1, 2, 3)  // <Int>
//
//let observable3 = Observable.of([1, 2, 3])  // <[Int]>
//
//let observable4 = Observable.from([1, 2, 3, 4])  // <Int>
//
//observable4.subscribe { event in
//    if let element = event.element {
//        print(element)  // 1 -> 2 -> 3 -> 4
//    }
//}
//
//observable4.subscribe(onNext: { element in
//    print(element)
//})
//
//observable3.subscribe { event in
//    if let element = event.element {
//        print(element)  // [1, 2, 3]
//    }
//}
//
//observable2.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//
//let subscription4 = observable4.subscribe(onNext: { event in
//    print(event)
//})
//
//subscription4.dispose()

let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
}.subscribe {
    print($0)
} onError: {
    print($0)
} onCompleted: {
    print("Completed")
} onDisposed: {
    print("Disposed")
}.disposed(by: disposeBag)

