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

