//
//  WIZHomePresenter.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit

protocol WIZHomePresentationLogic
{
  func presentGetMovies(response: WIZHome.GetMovies.Response)
  
}

class  WIZHomePresenter: WIZHomePresentationLogic {
  weak var viewController: WIZHomeDisplayLogic?
  
  func presentGetMovies(response: WIZHome.GetMovies.Response) {
    let viewModel = WIZHome.GetMovies.ViewModel(movieList: response.movieList, message: response.message)
    viewController?.displayGetMovies(viewModel: viewModel)
  }
}
