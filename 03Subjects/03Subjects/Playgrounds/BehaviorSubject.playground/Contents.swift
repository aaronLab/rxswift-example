import Foundation
import RxSwift

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

let subject = BehaviorSubject(value: "Initial value")
let bag = DisposeBag()

subject
    .subscribe {
        print(label: "1)", event: $0)
    }
    .disposed(by: bag)

subject.onNext("X")

subject.onError(MyError.anError)

subject
    .subscribe {
        print(label: "2)", event: $0)
    }
    .disposed(by: bag)
