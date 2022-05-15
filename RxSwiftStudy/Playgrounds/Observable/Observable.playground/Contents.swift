import Foundation

import RxSwift

let disposeBag = DisposeBag()

print("\n===============[ just ]===============\n")

Observable.just("Hello, RxSwift!")
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ of 1 ]===============\n")

Observable.of(1, 2, 3)
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ of 2 ]===============\n")

Observable.of([1, 2, 3])
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ from ]===============\n")

Observable.from([1, 2, 3])
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

print("\n===============[ empty ]===============\n")

Observable<Void>.empty()
  .subscribe(
    onNext: {
      print($0)
    },
    onError: {
      print($0)
    },
    onCompleted: {
      print("completed")
    },
    onDisposed: {
      print("disposed")
    })
  .disposed(by: disposeBag)

print("\n===============[ never ]===============\n")

Observable<Void>.never()
  .subscribe(
    onNext: {
      print($0)
    },
    onError: {
      print($0)
    },
    onCompleted: {
      print("completed")
    },
    onDisposed: {
      print("disposed")
    })
  .disposed(by: disposeBag)

print("\n===============[ create ]===============\n")

enum MyError: Error {
  case anError
}

Observable<Int>.create { observer -> Disposable in
  observer.onNext(1)
  observer.onNext(2)
  observer.onError(MyError.anError)
  observer.onCompleted()
  return Disposables.create()
}
.subscribe(
  onNext: {
    print($0)
  },
  onError: {
    print($0)
  },
  onCompleted: {
    print("completed")
  },
  onDisposed: {
    print("disposed")
  })
.disposed(by: disposeBag)
