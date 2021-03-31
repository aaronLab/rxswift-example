import Foundation
import RxSwift

let subject = PublishSubject<String>()

subject.on(.next("Is anyone listening?"))

let subscriptionOne = subject
    .subscribe(onNext: { string in
        print(string)
    })

subject.on(.next("1"))
subject.onNext("2")

let subscriptionTwo = subject
    .subscribe { event in
        guard let el = event.element else { return }
        print("2) \(el)")
    }

subject.onNext("3")

subscriptionOne.dispose()

subject.onNext("4")

subject.onCompleted()

subject.onNext("5")

subscriptionTwo.dispose()

let bag = DisposeBag()

subject
    .subscribe {
        guard let el = $0.element else { return }
        print("3) \(el)")
    }
    .disposed(by: bag)

subject.onNext("?")
