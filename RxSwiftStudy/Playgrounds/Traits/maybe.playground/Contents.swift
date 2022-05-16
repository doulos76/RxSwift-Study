import Foundation

import RxSwift

let disposeBag = DisposeBag()

print("\n===============[ maybe 1 ]===============\n")

Maybe<Void>.never()//just(Void())//just("Hello, Maybe")
  .subscribe(
    onSuccess: {
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
    }
  )
  .disposed(by: disposeBag)

print("\n===============[ maybe 2 ]===============\n")

Observable.just("Hello, Maybe")
  .asMaybe()
  .subscribe(
    onSuccess: {
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
    }
  )
  .disposed(by: disposeBag)
