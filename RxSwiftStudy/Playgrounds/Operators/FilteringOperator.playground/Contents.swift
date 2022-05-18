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


