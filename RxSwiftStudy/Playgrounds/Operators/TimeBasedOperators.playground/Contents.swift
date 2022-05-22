import Foundation

import RxSwift
import RxCocoa
import Dispatch

let disposeBag = DisposeBag()

example(of: "replay") {
  let greeting = PublishSubject<String>()
  let repeatBird = greeting.replay(2)
  repeatBird.connect()
  
  greeting.onNext("1. hello")
  greeting.onNext("2. Hi")
  
  repeatBird
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
  greeting.onNext("3. hello")
}

example(of: "replaytAll") {
  let drStrange = PublishSubject<String>()
  let timeStone = drStrange.replayAll()
  timeStone.connect()
  
  drStrange.onNext("도르마무")
  drStrange.onNext("거래를 하려왔다.")
  
  timeStone
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
}

//example(of: "buffer") {
//  let source = PublishSubject<String>()
//   var count = 0
//  let timer = DispatchSource.makeTimerSource()
//  timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//  timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//  }
//  timer.resume()
//
//  source
//    .buffer(timeSpan: .seconds(2), count: 2, scheduler: MainScheduler.instance)
//    .subscribe(onNext: { print($0) })
//    .disposed(by: disposeBag)
//}

