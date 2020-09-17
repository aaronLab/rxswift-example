import UIKit
import RxSwift
import RxCocoa

/*
 Implement Observables
 */

let observable = Observable.just(1)

let observable2 = Observable.of(1, 2, 3)

let observable3 = Observable.of([1, 2, 3])

let observable4 = Observable.from([1, 2, 3, 4, 5])

line()

/*
 Implement Subscriptions
 */

observable4.subscribe { (event) in
    if let element = event.element {
        print(element)  // single values
    }
    if event.isCompleted {
        print("completed")
    }
}

observable3.subscribe { (event) in
    if let element = event.element {
        print(element)  // array
    }
}

observable4.subscribe(onNext: { element in
    // don't have to unwrap
    print(element)  // single values
})

line()

/*
 Disposing and Terminating
 */

let subscription4 = observable4.subscribe(onNext: { event in
    print(event)
})

subscription4.dispose()

let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

Observable<String>.create { (observer) in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")  // will be never called
    return Disposables.create()
}.subscribe(
    onNext: { print($0) },
    onError: { print($0)},
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
).disposed(by: disposeBag)

line()

/*
 Publish Subjects
 */

let subject = PublishSubject<String>()

subject.onNext("Issue 1")  // won't be printed

subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 2")
subject.onNext("Issue 3")

//subject.dispose()
subject.onCompleted()

subject.onNext("Issue 4")

line()

/*
 Behavior Subjects
 */

let subject2 = BehaviorSubject(value: "Initial Value")

subject2.onNext("Last Issue")  // --> will ignore Initial Value

subject2.subscribe { event in
    print(event)  // ---> next(Initial Value)
}

subject2.onNext("Issue 1")

line()

/*
 Replay Subjects
 */

let subject3 = ReplaySubject<String>.create(bufferSize: 2)

subject3.onNext("Issue 1")  // won't be printed
subject3.onNext("Issue 2")
subject3.onNext("Issue 3")

subject3.subscribe { print($0) }  // ---> 2, 3

subject3.onNext("Issue 4")
subject3.onNext("Issue 5")
subject3.onNext("Issue 6")

print("[Subscription2]")
subject3.subscribe { print($0) }  // ---> 5, 6

line()

/*
 Variable
 */

let variable = Variable([String]())

variable.value.append("Item 1")

variable.asObservable()
    .subscribe { print($0) }

variable.value.append("Item 2")

line()

/*
 BehaviorRelay (Varibale is deprecated)
 which is related to RxCocoa
 So have to import `RxCocoa`
 */

let relay = BehaviorRelay(value: ["Item 1"])

var value = relay.value

value.append("Item 2")
value.append("Item 3")

// have to use accept instead of "value", which is read-only property
relay.accept(value)

//relay.accept(["Item 2"])  // ---> will remove the initial value
//relay.accept(relay.value + ["Item 2"])

relay.asObservable()
    .subscribe { print($0) }


func line() {
    print("==============================")
}
