import UIKit

import RxSwift

let disposeBag = DisposeBag()

print("\n===============[ PublishSubject ]===============\n")

let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. Hello, Everyone.")

let subscriber1 = publishSubject
  .subscribe(onNext: {
    print("subscriber1 : \($0)")
  })
  //.disposed(by: disposeBag)

publishSubject.onNext("2. Can you hear me?")
publishSubject.onNext("3. cane you hear?")

subscriber1.dispose()

let subscriber2 = publishSubject
  .subscribe(onNext: {
    print("subscriber2: \($0)")
  })

publishSubject.onNext("4. hello?")
publishSubject.onCompleted()
publishSubject.onNext("5. the end?")
subscriber2.dispose()

publishSubject
  .subscribe {
    print("subscriber3: ", $0.element ?? $0)
  }
  .disposed(by: disposeBag)

publishSubject.onNext("5. printed?")

print("\n===============[ Behavior Subject ]===============\n")

enum SubjectError: Error {
  case anError
}

let behaviorSubject = BehaviorSubject<String>(value: "0. 초기값")
behaviorSubject.onNext("1. 첫번째값")

behaviorSubject.subscribe {
  print("첫번째 구독", $0.element ?? $0)
}

//behaviorSubject.onError(SubjectError.anError)

behaviorSubject.subscribe {
  print("두번째 구독", $0.element ?? $0)
}
.disposed(by: disposeBag)

let value = try? behaviorSubject.value()
print(value)

print("\n===============[ Replay Subject ]===============\n")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만")

replaySubject.subscribe {
  print("첫번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. 할수있어요.")

replaySubject.onError(SubjectError.anError)
replaySubject.dispose()

replaySubject.subscribe {
  print("세번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)
