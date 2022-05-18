import UIKit

import RxSwift

let disposeBag = DisposeBag()

print("\n===============[ ignoreElements ]===============\n")

let sleepMode = PublishSubject<String>()

sleepMode
  .ignoreElements()
  .subscribe {
    print($0)
  }
  .disposed(by: disposeBag)

sleepMode.onNext("🔊")
sleepMode.onNext("🔊")
sleepMode.onNext("🔊")

sleepMode.onCompleted()

print("\n===============[ elementAt ]===============\n")

let personWhoAwakeningWhenTwoAlarm = PublishSubject<String>()

personWhoAwakeningWhenTwoAlarm
  .element(at: 1)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

personWhoAwakeningWhenTwoAlarm.onNext("0. 🔊")
personWhoAwakeningWhenTwoAlarm.onNext("1. 🔊")
personWhoAwakeningWhenTwoAlarm.onNext("2. 😂")
personWhoAwakeningWhenTwoAlarm.onNext("3. 🔊")

print("\n===============[ filter ]===============\n")

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  .filter { $0 % 2 == 0 }
  .subscribe(onNext: { print($0 )})
  .disposed(by: disposeBag)

print("\n===============[ skip ]===============\n")

Observable.of("1. 😀", "2. 😁", "3. 🥹", "4. 😅", "5. 😎", "6. 🤪")
  .skip(5)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ skipWhile ]===============\n")
// skip(while:)
// Bypasses elements in an observable sequence as long as a specified condition is true and then returns the remaining elements.

Observable.of("😀", "😁", "🥹", "😅", "😎", "🤪", "🐶", "😝", "🥰", "🙂", "🤓")
  .skip(while: {
    $0 != "🐶"
  })
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ skip(until) ]===============\n")
// skip(until:)
// Returns the elements from the source observable sequence that are emitted after the other observable sequence produces an element.

let guest = PublishSubject<String>()
let openTime = PublishSubject<String>()

guest
  .skip(until: openTime)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

guest.onNext("🤓")
guest.onNext("😅")
openTime.onNext("🔔 open")
guest.onNext("😎")
guest.onNext("😂")

print("\n===============[ take ]===============\n")
// Returns a specified number of contiguous elements from the start of an observable sequence.

Observable.of("🥇", "🥈", "🥉", "🤓", "😎")
  .take(3)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ takeWhile ]===============\n")
// Returns elements from an observable sequence as long as a specified condition is true.
Observable.of("🥇", "🥈", "🥉", "🤓", "😎")
  .take(while: { $0 != "🥉" })
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

print("\n===============[ takeUntil ]===============\n")
// Returns the elements from the source observable sequence until the other observable sequence produces an element.

let enrollment = PublishSubject<String>()
let deadline = PublishSubject<String>()

enrollment
  .take(until: deadline)
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

enrollment.onNext("😎")
enrollment.onNext("🤓")
deadline.onNext("End")
enrollment.onNext("🥹")

print("\n===============[ distinctUntilChanged ]===============\n")
// Returns an observable sequence that contains only distinct contiguous elements according to equality operator.

Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "입니다.", "저는", "저는", "저는", "앵무새", "앵무새", "일까요?", "일까요?")
  .distinctUntilChanged()
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)
