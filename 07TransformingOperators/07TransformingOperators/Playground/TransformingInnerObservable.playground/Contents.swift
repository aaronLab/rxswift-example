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

print("-----")

let laura = Student(score: BehaviorSubject<Int>(value: 80))
let charlotte = Student(score: BehaviorSubject<Int>(value: 90))

let student2 = PublishSubject<Student>()

student2
    .flatMapLatest {
        $0.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

student2.onNext(laura) // <<
laura.score.onNext(85) // <<
student2.onNext(charlotte) // <<

laura.score.onNext(95)
charlotte.score.onNext(100) // <<
laura.score.onNext(99)
