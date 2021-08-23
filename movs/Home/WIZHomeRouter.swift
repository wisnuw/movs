//
//  WIZHomeRouter.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift

protocol WIZHomeRouterLogic {
  var viewController: UIViewController? { get set }
  static func assembleModule() -> WIZHomeViewController
  func presentGenreList(list:[GenresMDB], completionHandler : @escaping (Int) -> Void)
  func presentMovieDetail(movieId:Int)
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
  
  func presentGenreList(list:[GenresMDB], completionHandler : @escaping (Int) -> Void) {
    let listVC = WIZListTableViewController(style: .plain)
    listVC.list = list
    listVC.completionHandler = completionHandler
    listVC.modalPresentationStyle = .overCurrentContext
    viewController?.present(listVC, animated: true, completion: nil)
  }
  
  func presentMovieDetail(movieId:Int) {
    let movieDetailVC = WIZMovieDetailRouter.assembleModule(movieId: movieId)
    viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
  }
}
