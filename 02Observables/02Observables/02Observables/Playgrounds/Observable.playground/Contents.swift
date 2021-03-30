import Foundation
import RxSwift

let one = 1
let two = 2
let three = 3

let observable1 = Observable<Int>.just(one)
let observable2 = Observable.of(one, two, three)
let observable3 = Observable.of([one, two, three])
let observable4 = Observable.from([one, two, three])
