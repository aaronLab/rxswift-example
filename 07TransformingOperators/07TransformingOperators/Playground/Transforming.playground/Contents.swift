import Foundation
import RxSwift

let bag = DisposeBag()

Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: bag)


    
