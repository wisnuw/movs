//
//  WIZMovieDetailPresenterTest.swift
//  movsTests
//
//  Created by wisnu wardhana on 23/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import XCTest
import TMDBSwift
@testable import movs

class WIZMovieDetailPresenterTest: XCTestCase {

  var sut: WIZMovieDetailPresenter!
  
  override func setUp() {
    super.setUp()
    sut = WIZMovieDetailPresenter()
  }
  
  class WIZMovieDetailDisplayLogicSpy: WIZMovieDetailDisplayLogic {
    var viewModelDisplayGetMovieDetail: WIZMovieDetail.GetMovieDetail.ViewModel?
    var viewModelDisplayGetMovieReviews: WIZMovieDetail.GetMovieReviews.ViewModel?
    var viewModelDisplayGetMovieTrailers: WIZMovieDetail.GetMovieTrailers.ViewModel?
    
    // MARK: Spied methods
    func displayGetMovieDetail(viewModel: WIZMovieDetail.GetMovieDetail.ViewModel) {
      self.viewModelDisplayGetMovieDetail = viewModel
    }
    
    func displayGetMovieReviews(viewModel: WIZMovieDetail.GetMovieReviews.ViewModel) {
      self.viewModelDisplayGetMovieReviews = viewModel
    }
    
    func displayGetMovieTrailers(viewModel: WIZMovieDetail.GetMovieTrailers.ViewModel) {
      self.viewModelDisplayGetMovieTrailers = viewModel
    }
  }
}

