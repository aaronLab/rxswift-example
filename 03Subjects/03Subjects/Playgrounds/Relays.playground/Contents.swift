import Foundation
import RxSwift
import RxRelay

enum MyError: Error {
    case error
}

let bag = DisposeBag()
let relay = PublishRelay<String>()

relay.accept("Knock knock, anyone home?")

relay
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

relay.accept("1")

let relay2 = BehaviorRelay(value: "Initial Value")
relay2.accept("New Initial Value")

relay2
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

relay2.accept("1")

relay2
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

relay2.accept("2")

print(relay2.value)
