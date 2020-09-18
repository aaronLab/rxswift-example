import UIKit
import RxSwift
//import RxCocoa

let disposeBag = DisposeBag()

Observable.of(2, 4, 6, 7, 8)
    .takeWhile { $0 % 2 == 0}
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

// -> 2, 3, 6
