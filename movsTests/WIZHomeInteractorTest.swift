//
//  WIZHomeTest.swift
//  movsTests
//
//  Created by wisnu wardhana on 23/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import XCTest
@testable import movs

class WIZHomeInteractorTest: XCTestCase {
  var sut: WIZHomeInteractor!
  
  override func setUp() {
    super.setUp()
    sut = WIZHomeInteractor()
    sut.presenter = WIZHomePresentationLogicSpy()
  }
  
  class WIZHomePresentationLogicSpy: WIZHomePresentationLogic {
    
    var responseGetMovies: WIZHome.GetMovies.Response?
    
    // MARK: Spied methods
    func presentGetMovies(response: WIZHome.GetMovies.Response) {
      responseGetMovies = response
    }
  }
  
  func testGetMovies_Success() {
    let homePresentationLogicSpy = WIZHomePresentationLogicSpy()
    sut.presenter = homePresentationLogicSpy
    sut.getMovies(request: WIZHome.GetMovies.Request(query: ""))
    XCTAssertTrue(homePresentationLogicSpy.responseGetMovies?.movieList != nil)
  }
}
