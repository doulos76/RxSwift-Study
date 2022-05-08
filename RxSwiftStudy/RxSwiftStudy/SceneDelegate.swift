//
//  SceneDelegate.swift
//  RxSwiftStudy
//
//  Created by dave76 on 2019/11/12.
//  Copyright © 2019 dave76. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  let viewModel = MainViewModel()
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let rootViewController = MainViewController()
    rootViewController.bind(viewModel)
    let navigationController = UINavigationController(rootViewController: rootViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
