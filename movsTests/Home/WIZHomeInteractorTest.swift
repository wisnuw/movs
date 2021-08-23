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
  var expectation:XCTestExpectation!
  
  override func setUp() {
    super.setUp()
    sut = WIZHomeInteractor()
    sut.presenter = WIZHomePresentationLogicSpy()
    expectation = self.expectation(description: "Wait for data to load.")
  }
  
  class WIZHomePresentationLogicSpy: WIZHomePresentationLogic {
    
    var responseGetMovies: WIZHome.GetMovies.Response?
    var responseGetGenres: WIZHome.GetGenres.Response?
    var expectation:XCTestExpectation?
    
    // MARK: Spied methods
    func presentGetMovies(response: WIZHome.GetMovies.Response) {
      responseGetMovies = response
      expectation?.fulfill()
    }
    
    func presentGetGenres(response: WIZHome.GetGenres.Response) {
      responseGetGenres = response
      expectation?.fulfill()
    }
  }
  
  func testGetMovies_Success() {
    let homePresentationLogicSpy = WIZHomePresentationLogicSpy()
    homePresentationLogicSpy.expectation = expectation
    sut.presenter = homePresentationLogicSpy
    
    sut.getMovies(request: WIZHome.GetMovies.Request(genreId: nil, page: 1))
    waitForExpectations(timeout: 50, handler: nil)
    
    XCTAssertTrue((homePresentationLogicSpy.responseGetMovies?.movieList!.count)! > 0)
  }
  
  func testGetGenres() {
    let homePresentationLogicSpy = WIZHomePresentationLogicSpy()
    homePresentationLogicSpy.expectation = expectation
    sut.presenter = homePresentationLogicSpy
    
    sut.getGenres(request: WIZHome.GetGenres.Request())
    waitForExpectations(timeout: 50, handler: nil)
    
    XCTAssertTrue((homePresentationLogicSpy.responseGetGenres?.genres!.count)! > 0)
  }
}
