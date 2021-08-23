//
//  WIZMovieDetailTest.swift
//  movsTests
//
//  Created by wisnu wardhana on 23/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import XCTest
@testable import movs

class WIZMovieDetailInteractorTest: XCTestCase {
  var sut: WIZMovieDetailInteractor!
  var expectation:XCTestExpectation!
  
  override func setUp() {
    super.setUp()
    sut = WIZMovieDetailInteractor(movieId: 0)
    sut.presenter = WIZMovieDetailPresentationLogicSpy()
    expectation = self.expectation(description: "Wait for data to load.")
  }
  
  class WIZMovieDetailPresentationLogicSpy: WIZMovieDetailPresentationLogic {
    
    var responseGetMovieDetail: WIZMovieDetail.GetMovieDetail.Response?
    var responseGetMovieReviews: WIZMovieDetail.GetMovieReviews.Response?
    var responseGetMovieTrailers: WIZMovieDetail.GetMovieTrailers.Response?
    var expectation:XCTestExpectation?
    
    // MARK: Spied methods
    func presentGetMovieDetail(response: WIZMovieDetail.GetMovieDetail.Response) {
      responseGetMovieDetail = response
      expectation?.fulfill()
    }
    
    func presentGetMovieReviews(response: WIZMovieDetail.GetMovieReviews.Response) {
      responseGetMovieReviews = response
      expectation?.fulfill()
    }
    
    func presentGetMovieTrailers(response: WIZMovieDetail.GetMovieTrailers.Response) {
      responseGetMovieTrailers = response
      expectation?.fulfill()
    }
  }
  
  func testGetMovieDetail() {
    let movieDetailPresentationLogicSpy = WIZMovieDetailPresentationLogicSpy()
    movieDetailPresentationLogicSpy.expectation = expectation
    sut.presenter = movieDetailPresentationLogicSpy
    sut.movieId = 7984
    sut.getMovieDetail(request: WIZMovieDetail.GetMovieDetail.Request())
    
    waitForExpectations(timeout: 50, handler: nil)
    
    XCTAssertEqual(movieDetailPresentationLogicSpy.responseGetMovieDetail?.detail?.title, "In the Name of the Father")
  }
  
  func testGetMovieReviews() {
    let homePresentationLogicSpy = WIZMovieDetailPresentationLogicSpy()
    homePresentationLogicSpy.expectation = expectation
    sut.presenter = homePresentationLogicSpy
    sut.movieId = 49026
    
    sut.getMovieReviews(request: WIZMovieDetail.GetMovieReviews.Request(page: 1))
    waitForExpectations(timeout: 50, handler: nil)
    
    let review = homePresentationLogicSpy.responseGetMovieReviews?.reviews?[0]
    XCTAssertEqual(review?.id, "5010553819c2952d1b000451")
    XCTAssertEqual(review?.author, "Travis Bell")
    XCTAssertNotNil(review?.content)
    XCTAssertEqual(review?.url, "https://www.themoviedb.org/review/5010553819c2952d1b000451")
  }
  
  func testGetMovieTrailers() {
    let homePresentationLogicSpy = WIZMovieDetailPresentationLogicSpy()
    homePresentationLogicSpy.expectation = expectation
    sut.presenter = homePresentationLogicSpy
    sut.movieId = 871
    
    sut.getMovieTrailers(request: WIZMovieDetail.GetMovieTrailers.Request())
    waitForExpectations(timeout: 50, handler: nil)
    
    let vids = homePresentationLogicSpy.responseGetMovieTrailers?.videos?[0]
    XCTAssertEqual(vids?.id, "6106a552a76ac5005c15b418")
    XCTAssertEqual(vids?.iso_639_1, "en")
    XCTAssertEqual(vids?.key, "BWh16oVpTBc")
    XCTAssertEqual(vids?.name, "Planet of the Apes (1968) - Teaser Trailer HD 1080p")
    XCTAssertEqual(vids?.site, "YouTube")
    XCTAssertEqual(vids?.size, 1080)
    XCTAssertEqual(vids?.type, "Trailer")
    
  }
}
