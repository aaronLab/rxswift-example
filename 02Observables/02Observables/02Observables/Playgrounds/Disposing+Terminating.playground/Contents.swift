import Foundation
import RxSwift

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


