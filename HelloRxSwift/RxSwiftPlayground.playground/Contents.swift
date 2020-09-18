import UIKit
import RxSwift
//import RxCocoa

let disposeBag = DisposeBag()

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)  // only even numbers will be printed
    }).disposed(by: disposeBag)
