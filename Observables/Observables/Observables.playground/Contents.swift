import UIKit
import RxSwift

let observable1 = Observable.just(1)

let observable2 = Observable.of(1, 2, 3)

let observable3 = Observable.of([1, 2, 3])

let observable4 = Observable.from([1, 2, 3, 4, 5])

print("==============================")
print("from...[1, 2, 3, 4, 5]")
observable4.subscribe { event in
    guard let element = event.element else { return }
    // by each order
    print(element)
}
print("==============================")



print("of...[1, 2, 3]")
observable3.subscribe { event in
    guard let element = event.element else { return }
    // at once
    print(element)
}
print("==============================")

print("onNext...")
observable4.subscribe(onNext: { element in
    // without unwrapping
    print(element)
})
print("==============================")
