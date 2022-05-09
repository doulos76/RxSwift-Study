//
//  MainViewModel.swift
//  RxSwiftStudy
//
//  Created by MinHoo Goo on 2022/05/09.
//  Copyright © 2022 dave76. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

struct MainViewModel {
  let input = Input()
  let output = Output()
 
  init(_ model: MainModel = MainModel()) {
    output.items.accept(model.models)
  }

}

extension MainViewModel {
  struct Input {

  }
}

extension MainViewModel {
  struct Output {
    let items = BehaviorRelay<[String]>(value: [])
  }
}

struct MainModel {
  let models = (0...50).map { "Item: #\($0)" }
}
