import UIKit
import RxSwift
//import RxCocoa

let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

strikes
    .ignoreElements()
    .subscribe { _ in
        print("[Subscription is called]")
    }.disposed(by: disposeBag)

strikes.onNext("A")  // will be ignored
strikes.onNext("B")  // will be ignored
strikes.onNext("C")  // will be ignored

strikes.onCompleted()
