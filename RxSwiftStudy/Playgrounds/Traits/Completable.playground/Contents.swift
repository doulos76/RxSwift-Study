import Foundation

import RxSwift

let disposeBag = DisposeBag()

enum TraitError: Error {
  case completable
}

print("\n===============[ completable 1 ]===============\n")

Completable.create { observer -> Disposable in
  observer(.completed)
  return Disposables.create()
}
.subscribe(
  onCompleted: {
    print("Completed")
  }, onError: {
    print("Error: ", $0)
  }, onDisposed: {
    print("disposed")
  })
.disposed(by: disposeBag)

print("\n===============[ completable 2 ]===============\n")

Completable.create { observer -> Disposable in
  observer(.error(TraitError.completable))
  return Disposables.create()
}
.subscribe(
  onCompleted: {
    print("Completed")
  }, onError: {
    print("Error: ", $0)
  }, onDisposed: {
    print("disposed")
  })
.disposed(by: disposeBag)
