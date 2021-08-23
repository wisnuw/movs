//
//  WIZHomePresenterTest.swift
//  movsTests
//
//  Created by wisnu wardhana on 23/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import XCTest
@testable import movs

class WIZHomePresenterTest: XCTestCase {

  var sut: WIZHomePresenter!
  
  override func setUp() {
    super.setUp()
    sut = WIZHomePresenter()
  }
  
  class WIZHomeDisplayLogicSpy: WIZHomeDisplayLogic {
    
    var viewModelDisplayGetMovies: WIZHome.GetMovies.ViewModel?
    
    // MARK: Spied methods
    func displayGetMovies(viewModel: WIZHome.GetMovies.ViewModel) {
      self.viewModelDisplayGetMovies = viewModel
    }
  }
  
  func testPresentGetMovies() {
    let homeDisplayLogicSpy = WIZHomeDisplayLogicSpy()
    sut.viewController = homeDisplayLogicSpy
    
    let movie1 = WIZHome.Movie(id: "1", title: "Title 1")
    let movie2 = WIZHome.Movie(id: "2", title: "Title 2")
    let movie3 = WIZHome.Movie(id: "3", title: "Title 3")
    let movie4 = WIZHome.Movie(id: "4", title: "Title 4")
    
    sut.presentGetMovies(response: WIZHome.GetMovies.Response(movieList: [movie1,movie2,movie3,movie4], message: "success"))
    XCTAssertTrue(homeDisplayLogicSpy.viewModelDisplayGetMovies?.movieList?.count == 4)
  }
}

