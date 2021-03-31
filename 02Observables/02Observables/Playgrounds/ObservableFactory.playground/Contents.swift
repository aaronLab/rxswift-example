import Foundation
import RxSwift

let bag = DisposeBag()

var flip = false

let factory: Observable<Int> = Observable.deferred {
    
    flip.toggle()
    
    return flip ? Observable.of(1, 2, 3) : Observable.of(4, 5, 6)
    
}


for _ in 0...3 {
    
    factory.subscribe(onNext: {
        print($0, terminator: "")
    })
    .disposed(by: bag)
    
    print()
    
}
