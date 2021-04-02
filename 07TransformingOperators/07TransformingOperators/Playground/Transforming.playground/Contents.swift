import Foundation
import RxSwift

let bag = DisposeBag()

Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: bag)

print("map")

let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

Observable<Int>.of(123, 4, 56)
    .map {
        formatter.string(for: $0) ?? ""
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

print("enumerated")

Observable.of(1, 2, 3, 4, 5, 6)
    .enumerated()
    .map { index, i in
        index > 2 ? i * 2 : i
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)
    
