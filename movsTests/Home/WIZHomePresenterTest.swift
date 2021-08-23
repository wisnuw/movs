//
//  WIZHomePresenterTest.swift
//  movsTests
//
//  Created by wisnu wardhana on 23/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import XCTest
import TMDBSwift
@testable import movs

class WIZHomePresenterTest: XCTestCase {

  var sut: WIZHomePresenter!
  
  override func setUp() {
    super.setUp()
    sut = WIZHomePresenter()
  }
  
  class WIZHomeDisplayLogicSpy: WIZHomeDisplayLogic {
    var viewModelDisplayGetMovies: WIZHome.GetMovies.ViewModel?
    var viewModelDisplayGetGenres: WIZHome.GetGenres.ViewModel?
    
    // MARK: Spied methods
    func displayGetMovies(viewModel: WIZHome.GetMovies.ViewModel) {
      self.viewModelDisplayGetMovies = viewModel
    }
    
    func displayGetGenres(viewModel: WIZHome.GetGenres.ViewModel) {
      self.viewModelDisplayGetGenres = viewModel
    }
  }
  
  func testPresentGetMovies() {
    let homeDisplayLogicSpy = WIZHomeDisplayLogicSpy()
    sut.viewController = homeDisplayLogicSpy
    var data:[MovieMDB]!
    let expectation = self.expectation(description: "Wait for data to load.")
    
    MovieMDB.discoverMovies(params: [.page(1), .language("en"), .vote_count_gte(10000)], completion: {
      api, movie in
      data = movie
      expectation.fulfill()
    })
    waitForExpectations(timeout: 50, handler: nil)
    
    sut.presentGetMovies(response: WIZHome.GetMovies.Response(movieList:data, message: "success"))
    XCTAssertTrue(homeDisplayLogicSpy.viewModelDisplayGetMovies?.movieList?.count == 20)
  }
  
  func testPresentGetGenres() {
    let homeDisplayLogicSpy = WIZHomeDisplayLogicSpy()
    sut.viewController = homeDisplayLogicSpy
    var data:[GenresMDB]!
    let expectation = self.expectation(description: "Wait for data to load.")
    
    GenresMDB.genres(listType: GenresListType.movie, language: "en") { (api, genres) in
      data = genres
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 50, handler: nil)
    
    sut.presentGetGenres(response: WIZHome.GetGenres.Response(genres:data, message: ""))
    XCTAssertTrue((homeDisplayLogicSpy.viewModelDisplayGetGenres?.genres!.count)! > 0)
  }
}

