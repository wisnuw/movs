//
//  WIZHomeInteractor.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift

protocol WIZMovieDetailBusinessLogic
{
  func getMovieDetail(request:WIZMovieDetail.GetMovieDetail.Request)
  func getMovieReviews(request:WIZMovieDetail.GetMovieReviews.Request)
  func getMovieTrailers(request:WIZMovieDetail.GetMovieTrailers.Request)
}

class WIZMovieDetailInteractor: WIZMovieDetailBusinessLogic {
  var presenter: WIZMovieDetailPresentationLogic?
  var reviews: [MovieReviewsMDB]!
  var detail: MovieDetailedMDB?
  var trailers: [VideosMDB]!
  var movieId:Int!
  
  init(movieId:Int) {
    self.movieId = movieId
  }
  
  func getMovieDetail(request:WIZMovieDetail.GetMovieDetail.Request) {
    MovieMDB.movie(movieID: self.movieId){ api, movie in
      var message:String = ""
      if let error = api.error {
        message = error.localizedDescription
      }
      else {
        self.detail = movie
      }
      
      let response = WIZMovieDetail.GetMovieDetail.Response(detail:self.detail, message: message)
      self.presenter?.presentGetMovieDetail(response: response)
    }
  }
  
  func getMovieReviews(request:WIZMovieDetail.GetMovieReviews.Request) {
    MovieMDB.reviews(movieID: self.movieId, page: request.page) { api, reviews in
      var message:String = ""
      if let error = api.error {
        self.reviews = []
        message = error.localizedDescription
      }
      else {
        self.reviews = reviews
      }
      
      let response = WIZMovieDetail.GetMovieReviews.Response(reviews: self.reviews, message: message)
      self.presenter?.presentGetMovieReviews(response: response)
    }
  }
  
  func getMovieTrailers(request:WIZMovieDetail.GetMovieTrailers.Request) {
    MovieMDB.videos(movieID: self.movieId){ api, vids in
      var message:String = ""
      if let error = api.error {
        message = error.localizedDescription
      }
      else {
        self.trailers = vids
      }
      
      let response = WIZMovieDetail.GetMovieTrailers.Response(videos: self.trailers, message: message)
      self.presenter?.presentGetMovieTrailers(response: response)
    }
  }
  
}
