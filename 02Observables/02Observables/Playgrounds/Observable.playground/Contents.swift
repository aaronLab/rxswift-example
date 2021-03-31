import Foundation
import RxSwift

let one = 1
let two = 2
let three = 3

let observable1 = Observable<Int>.just(one)
let observable2 = Observable.of(one, two, three)
let observable3 = Observable.of([one, two, three])
let observable4 = Observable.from([one, two, three])

observable2.subscribe { event in
    if let element = event.element {
        print(element)
    }
}

print()

observable2.subscribe(onNext: { element in
    print(element)
})

print()

observable4.subscribe { event in
    print(event)
}

print()

let observable5 = Observable<Void>.empty()

observable5.subscribe(
    onNext: { element in
        print(element)
    },
    onCompleted:  {
        print("Completed")
    }
)

//print()
//
//let observable6 = Observable<Void>.never()
//
//observable6
//    .do(onSubscribe: {
//        print("Subscribed")
//    })
//    .subscribe(
//        onNext: { element in
//            print(element)
//        },
//        onCompleted: {
//            print("Completed")
//        },
//        onDisposed: {
//            print("Disposed")
//        }
//    )

print()

let observable7 = Observable<Int>.range(start: 1, count: 10)

observable7
    .subscribe(onNext: { i in
        
        let n = Double(i)
        
        let fibonacci = Int(
            ((pow(1.61803, n) - pow(0.61803, n)) /
                2.23606).rounded()
        )
        
        print(fibonacci)
        
    })
