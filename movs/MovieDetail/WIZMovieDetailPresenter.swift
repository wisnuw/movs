//
//  WIZMovieDetailPresenter.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit

protocol WIZMovieDetailPresentationLogic
{
  func presentGetMovieDetail(response: WIZMovieDetail.GetMovieDetail.Response)
  func presentGetMovieReviews(response: WIZMovieDetail.GetMovieReviews.Response)
  func presentGetMovieTrailers(response: WIZMovieDetail.GetMovieTrailers.Response)
}

class WIZMovieDetailPresenter: WIZMovieDetailPresentationLogic {
  weak var viewController: WIZMovieDetailDisplayLogic?
  
  func presentGetMovieDetail(response: WIZMovieDetail.GetMovieDetail.Response) {
    let viewModel = WIZMovieDetail.GetMovieDetail.ViewModel(detail: response.detail, message: response.message)
    viewController?.displayGetMovieDetail(viewModel: viewModel)
  }
  
  func presentGetMovieReviews(response: WIZMovieDetail.GetMovieReviews.Response) {
    let viewModel = WIZMovieDetail.GetMovieReviews.ViewModel(reviews: response.reviews, message: response.message)
    viewController?.displayGetMovieReviews(viewModel: viewModel)
  }
  
  func presentGetMovieTrailers(response: WIZMovieDetail.GetMovieTrailers.Response) {
    let viewModel = WIZMovieDetail.GetMovieTrailers.ViewModel(videos: response.videos, message: response.message)
    viewController?.displayGetMovieTrailers(viewModel: viewModel)
  }
  
}
