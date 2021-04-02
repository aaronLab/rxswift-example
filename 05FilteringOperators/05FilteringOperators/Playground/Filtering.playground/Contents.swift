import Foundation
import RxSwift

let strikes = PublishSubject<String>()

let bag = DisposeBag()

strikes
//    .ignoreElements()
    .element(at: 2)
    .subscribe(onNext: { _ in
        print("YOU'RE OUT!")
    })
    .disposed(by: bag)

print("element(at:_)")
strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X")

print("filter")
Observable.of(1, 2, 3, 4, 5, 6)
    .filter { $0.isMultiple(of: 2) }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

print("skip(:_)")
Observable.of("A", "B", "C", "D", "E", "F")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

print("skipWhile")
Observable.of(2, 2, 3, 4, 4)
    .skip(while: { $0.isMultiple(of: 2) })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)
