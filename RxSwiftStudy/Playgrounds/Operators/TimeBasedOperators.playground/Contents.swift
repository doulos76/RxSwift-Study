import Foundation
import PlaygroundSupport

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

//example(of: "window") {
//  let numberOfObervableMakeable = 5
//  let makaableTime = RxTimeInterval.seconds(2)
//
//  let window = PublishSubject<String>()
//  var windowCount = 0
//
//  let windowTimeSource = DispatchSource.makeTimerSource()
//  windowTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//  windowTimeSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//  }
//  windowTimeSource.resume()
//
//  window
//    .window(
//      timeSpan: makaableTime,
//      count: numberOfObervableMakeable,
//      scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//      return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//      print("\($0.index) 번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)
//}

//example(of: "delaySubscription") {
//  let delaySource = PublishSubject<String>()
//  var delayCount = 0
//  let delayTimeSource = DispatchSource.makeTimerSource()
//  delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//  delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//  }
//  delayTimeSource.resume()
//  delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: { print($0) })
//    .disposed(by: disposeBag)
//}


//example(of: "delay") {
//  let delaySubject = PublishSubject<Int>()
//
//  var delayCount = 0
//  let delayTimerSource = DispatchSource.makeTimerSource()
//  delayTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//  delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext(delayCount)
//  }
//  delayTimerSource.resume()
//
//  delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: { print($0) })
//    .disposed(by: disposeBag)
//}

//example(of: "interval") {
//  Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .take(5)
//    .subscribe(onNext: { print($0, "\(Date())") })
//    .disposed(by: disposeBag)
//}

//example(of: "timer") {
//  Observable<Int>
//    .timer(.seconds(5), period: .seconds(2), scheduler: MainScheduler.instance)
//    .subscribe(onNext: { print($0) })
//    .disposed(by: disposeBag)
//}

example(of: "timeout") {
  let errorButtonDontPush = UIButton(type: .system)
  errorButtonDontPush.setTitle("눌러주세요!", for: .normal)
  errorButtonDontPush.sizeToFit()
  
  PlaygroundPage.current.liveView = errorButtonDontPush
  
  errorButtonDontPush.rx.tap
    .do(onNext: {
      print("tap")
    })
      .timeout(.seconds(5), scheduler: MainScheduler.instance)
      .subscribe(onNext: { print($0) })
      .disposed(by: disposeBag)
  
}
