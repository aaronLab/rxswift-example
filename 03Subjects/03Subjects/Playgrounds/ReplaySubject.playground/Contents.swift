import Foundation
import RxSwift

enum MyError: Error {
    case myError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

let subject = ReplaySubject<String>.create(bufferSize: 2)
let bag = DisposeBag()

subject.onNext("1")
subject.onNext("2")
subject.onNext("3")

subject
    .subscribe {
        print(label: "1)", event: $0)
    }
    .disposed(by: bag)

subject
    .subscribe {
        print(label: "2)", event: $0)
    }
    .disposed(by: bag)

subject.onNext("4")
subject.onError(MyError.myError)
subject.dispose()

subject
    .subscribe {
        print(label: "3)", event: $0)
    }
    .disposed(by: bag)
