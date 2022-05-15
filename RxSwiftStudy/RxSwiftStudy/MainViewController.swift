//
//  MainViewController.swift
//  RxSwiftStudy
//
//  Created by MinHoo Goo on 2022/05/09.
//  Copyright © 2022 dave76. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class MainViewController: UIViewController {

  // MARK: - Properties

  let disposeBag = DisposeBag()

  private lazy var tableView = UITableView().then {
    $0.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
  }

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    layoutUI()
  }

  
  
  // MARK: - Setup Methods

  func bind(_ viewModel: MainViewModel) {
    viewModel.output
      .items
      .bind(to: tableView.rx.items(cellIdentifier: MainCell.identifier, cellType: MainCell.self)
    ) { index, data, cell in
      cell.textLabel?.text = data
    }
    .disposed(by: disposeBag)
  }

  private func attribute() {
    view.backgroundColor =  .white
  }

  private func layoutUI() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
