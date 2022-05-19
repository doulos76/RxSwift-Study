import RxSwift

let disposeBag = DisposeBag()

print("\n===============[ startWith ]===============\n")
// Prepends a sequence of values to an observable sequence.

let classYello = Observable<String>.of("😀boy1", "😁boy2", "😊boy3")

classYello
  .enumerated()
  .map { index, element in
    return element + " child " + "\(index)"
  }
  .startWith("👩🏻‍🦰teacher")
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ concat 1 ]===============\n")
let classYelloChildren = Observable<String>.of("😀boy1", "😁boy2", "😊boy3")
let teacher = Observable<String>.of("👩‍🔧 teacher")
//let teacher = Observable<String>.of("👩‍🔧 teacher", "🧑🏼‍🦰 assistant teacher")
let walkingInLine = Observable
  .concat([teacher, classYelloChildren])

walkingInLine
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ concat 2 ]===============\n")

teacher
  .concat(classYelloChildren)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ concatMap ]===============\n")

let houseOfChildren: [String: Observable<String>] = [
  "yellowClass": Observable.of("👧", "👧🏻", "👦🏽"),
  "blueClass": Observable.of("👶🏾", "👶🏻")
]

Observable.of("yellowClass", "blueClass")
  .concatMap { ban in
    houseOfChildren[ban] ?? .empty()
  }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ merge 1 ]===============\n")
// Merges elements from all observable sequences in the given enumerable sequence into a single observable sequence.

let gangbuk = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let gangnam = Observable.from(["강남구", "강동구", "여의도구", "양천구"])

Observable.of(gangbuk, gangnam)
  .merge()
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ merge 2 ]===============\n")
// Merges elements from all inner observable sequences into a single observable sequence, limiting the number of concurrent subscriptions to inner sequences.

Observable.of(gangnam, gangbuk)
  .merge(maxConcurrent: 1)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ combineLatest 1 ]===============\n")
let secondName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
  .combineLatest(secondName, firstName) { secondName, firstName in
    secondName + firstName
  }

fullName
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

secondName.onNext("김")
firstName.onNext("똘똘")
firstName.onNext("영수")
firstName.onNext("은영")
secondName.onNext("박")
secondName.onNext("이")
secondName.onNext("조")
