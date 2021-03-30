import RxSwift

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

strikes.element(at: 2)
    .subscribe(onNext: { _ in
        print("Out")
    }).disposed(by: disposeBag)

strikes.onNext("X") // never called
strikes.onNext("X") // never called
strikes.onNext("X") // will be called
