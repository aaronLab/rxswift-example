import RxSwift

let disposeBag = DisposeBag()

let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1") // not called
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe {  event in
    print(event)
}

subject.onNext("Issue 4")
subject.onNext("Issue 5")

print("=====Subscription 2=====")
subject.subscribe { event in
    print(event)
}
