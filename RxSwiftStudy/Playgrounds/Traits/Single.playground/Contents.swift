import Foundation

import RxSwift
let disposeBag = DisposeBag()

print("\n===============[ Single 1 ]===============\n")

Single<String>.just("Hello, world")
  .subscribe(
    onSuccess: {
      print($0)
    },
    onFailure: {
      print($0)
    },
    onDisposed: {
      print("disposed")
    })
  .disposed(by: disposeBag)

print("\n===============[ Single 2 ]===============\n")

Observable.just("Hello, world")
  .asSingle()
  .subscribe(
    onSuccess: {
      print($0)
    },
    onFailure: {
      print($0)
    },
    onDisposed: {
      print("disposed")
    })
  .disposed(by: disposeBag)

print("\n===============[ Single 3 ]===============\n")

enum MyError: Error {
  case single
}

Observable<String>.create { observer -> Disposable in
  observer.onNext("Hi")
  observer.onError(MyError.single)
  observer.onCompleted()
  return Disposables.create()
}
.asSingle()
.subscribe(
  onSuccess: {
    print($0)
  },
  onFailure: {
    print($0.localizedDescription)
  },
  onDisposed: {
    print("disposed")
  })
.disposed(by: disposeBag)

