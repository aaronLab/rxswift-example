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
