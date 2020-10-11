import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: - Observable

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


//Observable.of("A", "B", "C")
//    .subscribe {
//        print($0)
//    }.disposed(by: disposeBag)
//
//Observable<String>.create { observer in
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe {
//    print($0)
//} onError: {
//    print($0)
//} onCompleted: {
//    print("Completed")
//} onDisposed: {
//    print("Disposed")
//}.disposed(by: disposeBag)

// MARK: - PublishSubject

//let subject = PublishSubject<String>()
//
//subject.onNext("First")  // Not Work
//
//subject.subscribe { event in
//    print(event)
//}
//
//subject.onNext("Second")
//subject.onNext("Third")
//
//subject.dispose()  // Will be ignored after this
//
//subject.onCompleted()
//
//subject.onNext("Fourth")

// MARK: - BehaviorSubject

//let subject = BehaviorSubject(value: "Initial Value")
//
//subject.onNext("Last Issue")
//
//subject.subscribe { event in
//    print(event)
//}
//
//subject.onNext("Second Value")

// MARK: - ReplaySubject

//let subject = ReplaySubject<String>.create(bufferSize: 2)
//
//subject.onNext("1")
//subject.onNext("2")
//subject.onNext("3")
//
//subject.subscribe {
//    print($0)
//}
//
//subject.onNext("4")
//subject.onNext("5")
//subject.onNext("6")
//
//print("Subscription 2")
//subject.subscribe {
//    print($0)
//}

// MARK: - BehaviorRelay

let relay = BehaviorRelay(value: ["Item 1"])

//relay.value.append("Item")  // Error
//relay.accept(relay.value + ["Item 2"])

var value = relay.value
value.append("Item 2")
value.append("Item 2")

relay.accept(value)

relay.asObservable()
    .subscribe {
        print($0)
    }
