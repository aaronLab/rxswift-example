import RxSwift
import PlaygroundSupport

let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

strikes
    .ignoreElements()
    .subscribe { _ in
        print("[Subscription is called]")
    }
    .disposed(by: disposeBag)

strikes.onNext("A") // Never called
strikes.onNext("B") // Never called
strikes.onNext("C") // Never called

strikes.onCompleted() // Will be called
