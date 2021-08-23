//
//  WIZHomeRouter.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift

protocol WIZMovieDetailRouterLogic {
  var viewController: UIViewController? { get set }
  static func assembleModule(movieId:Int) -> WIZMovieDetailViewController
}

class WIZMovieDetailRouter: WIZMovieDetailRouterLogic {
  weak var viewController: UIViewController?
  
  static func assembleModule(movieId:Int) -> WIZMovieDetailViewController {
    let view = WIZMovieDetailViewController()
    let interactor = WIZMovieDetailInteractor(movieId: movieId)
    let presenter = WIZMovieDetailPresenter()
    let router = WIZMovieDetailRouter()
    
    // Connecting
    presenter.viewController = view
    view.interactor = interactor
    view.router = router
    interactor.presenter = presenter
    router.viewController = view
    return view
  }
}
