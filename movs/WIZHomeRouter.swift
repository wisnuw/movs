//
//  WIZHomeRouter.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit

protocol WIZHomeRouterLogic {
  var viewController: UIViewController? { get set }
  func presentMovieDetail()
}

class WIZHomeRouter: WIZHomeRouterLogic {
  weak var viewController: UIViewController?
  
  static func assembleModule() -> WIZHomeViewController {
    let view = WIZHomeViewController()
    let interactor = WIZHomeInteractor()
    let presenter = WIZHomePresenter()
    let router = WIZHomeRouter()
    
    // Connecting
    presenter.viewController = view
    view.interactor = interactor
    view.router = router
    interactor.presenter = presenter
    router.viewController = view
    return view
  }
  
  func presentMovieDetail() {
    
  }
}
