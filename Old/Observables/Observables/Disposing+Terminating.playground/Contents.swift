import RxSwift

let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe(onNext: { element in
        print(element)
    })
    .disposed(by: disposeBag)

print("=====")

Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?") // never called
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

