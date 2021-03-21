import UIKit
import RxSwift

let disposeBag = DisposeBag()

let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe {
    // => 2, 3, 4, 5, 6
    print($0)
}

subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

print("Subscription 2")
subject.subscribe {
    // => 5, 6
    print($0)
}
