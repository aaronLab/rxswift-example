import UIKit
import RxSwift
//import RxCocoa

let disposeBag = DisposeBag()

Observable.of("a", "b", "c", "d", "e", "f")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

// ---> d, e, f
