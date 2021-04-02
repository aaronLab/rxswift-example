import Foundation
import RxSwift

let bag = DisposeBag()

struct Student {
    
    let score: BehaviorSubject<Int>
    
}

let aaron = Student(score: BehaviorSubject<Int>(value: 80))
let syeda = Student(score: BehaviorSubject<Int>(value: 90))

let student = PublishSubject<Student>()

student
    .flatMap {
        $0.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

student.onNext(aaron)

aaron.score.onNext(85)

aaron.score.onNext(90)

student.onNext(syeda)

aaron.score.onNext(95)

syeda.score.onNext(95)

syeda.score.onNext(100)

aaron.score.onNext(90)
