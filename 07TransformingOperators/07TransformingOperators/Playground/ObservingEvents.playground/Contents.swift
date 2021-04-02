import Foundation
import RxSwift

struct Student {
    
    let score: BehaviorSubject<Int>
    
}

enum MyError: Error {
    case anError
}

let bag = DisposeBag()

let aaron = Student(score: BehaviorSubject<Int>(value: 80))
let syeda = Student(score: BehaviorSubject<Int>(value: 100))

let student = BehaviorSubject(value: aaron)

let studentScore = student
    .flatMapLatest {
        $0.score.materialize()
    }

//studentScore
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: bag)

studentScore
    .filter {
        guard $0.error == nil else {
            print($0.error!)
            return false
        }
        
        return true
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

aaron.score.onNext(85)
aaron.score.onError(MyError.anError)
aaron.score.onNext(90)

student.onNext(syeda)

// materialize makes the subjects Observable<Event<T>>
