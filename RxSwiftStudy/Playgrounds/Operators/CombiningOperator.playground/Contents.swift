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

print("\n===============[ combineLatest 2 ]===============\n")

let dateFormat = Observable<DateFormatter.Style>.of(.short, .long)
let currentDate = Observable<Date>.of(Date())

let currentDateDisplay = Observable
  .combineLatest(dateFormat, currentDate) { format, date -> String in
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = format
    return dateFormatter.string(from: date)
  }

currentDateDisplay
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ combineLatest 3 ]===============\n")

let lastName2 = PublishSubject<String>()
let firstName2 = PublishSubject<String>()
let fullName2 = Observable
  .combineLatest([firstName2, lastName2]) { name in
    name.joined(separator: " ")
  }

fullName2
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

lastName2.onNext("Kim")
firstName2.onNext("Paul")
firstName2.onNext("Stella")
firstName2.onNext("Lily")

print("\n===============[ zip ]===============\n")

enum Victory {
  case pass
  case fail
}

let victory = Observable<Victory>.of(.pass, .fail, .fail, .pass)
let player = Observable<String>.of("🇰🇷", "🇩🇰", "🇺🇸", "🇧🇷", "🇯🇵", "🇨🇳")

let result = Observable
  .zip(victory, player) { result, president in
    return president + "player" + " \(result)"
  }

result
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ withLatestFrom 1 ]===============\n")

let trigger = PublishSubject<Void>()
let runner = PublishSubject<String>()

trigger
  .withLatestFrom(runner)
  //.distinctUntilChanged()
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

runner.onNext("🏃‍♀️")
runner.onNext("🏃‍♀️  🏃🏻‍♀️")
runner.onNext("🏃‍♀️  🏃🏻‍♀️    🏃🏾‍♀️")

trigger.onNext(Void())
trigger.onNext(Void())

print("\n===============[ sample ]===============\n")

let start = PublishSubject<Void>()
let F1Player = PublishSubject<String>()

F1Player
  .sample(F1Player)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

F1Player.onNext("🏎")
F1Player.onNext("🏎        🚗")
F1Player.onNext("🏎        🚗   🚙")

start.onNext(Void())
start.onNext(Void())

print("\n===============[ amb ]===============\n")
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let busstop = bus1.amb(bus2)

busstop
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

bus2.onNext("bus2-passenger0: 👧")
bus1.onNext("bus1-passenger0: 🧒🏻")
bus1.onNext("bus1-passenger1: 👦🏽")
bus2.onNext("bus2-passenger1: 👩🏻‍🦳")
bus1.onNext("bus1-passenger1: 👴🏼")
bus2.onNext("bus2-passenger2: 👱🏻‍♀️")

print("\n===============[ switchLatest ]===============\n")

let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let handsUp = PublishSubject<Observable<String>>()
let classWithHandsUp = handsUp.switchLatest()

classWithHandsUp
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

handsUp.onNext(student1)
student1.onNext("학생 1 : 저는 1번 학생입니다.")
student2.onNext("학생 2 : 저요 저요!!!")

handsUp.onNext(student2)
student2.onNext("학생 2 : 저는 2번 학생이에요!")
student1.onNext("학생 1 : 아 .... 나 아직 할 말 있는데")

handsUp.onNext(student3)
student2.onNext("학생 2 : 아니 잠깐만! 내가! ")
student1.onNext("학생 1 : 언제 말 할 수 있죠?")
student3.onNext("학생 3 : 저는 3번 입니다~ 아무래도 제가 이긴 것 같아요")

handsUp.onNext(student1)
student1.onNext("학생 1 : 아니, 틀렸어. 승자는 나야")
student2.onNext("학생 2 : ㅠ.ㅠ")
student3.onNext("학생 3 : 이긴 줄 알았는데")
student2.onNext("학생 2 : 이거 이기고 지는 손들기였나요?")
student1.onNext("학생 1 : 이제는 말 할 수 있다.")

print("\n===============[ reduce ]===============\n")
Observable.from(1...10)
//  .reduce(0, accumulator: { summary, newValue in
//    return summary + newValue
//  })
//  .reduce(0) { summary, newValue in
//    return summary + newValue
//  }
  .reduce(0, accumulator: +)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ scan ]===============\n")

Observable.from(1...10)
  .scan(0, accumulator: +)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)
