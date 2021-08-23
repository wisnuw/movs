//
//  WIZHomeModels.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import TMDBSwift

enum WIZMovieDetail {
  enum GetMovieDetail {
    struct Request {
    }
    
    struct Response {
      var detail: MovieDetailedMDB?
      var message: String
    }
    struct ViewModel {
      var detail: MovieDetailedMDB?
      var message: String
    }
  }
  
  enum GetMovieReviews {
    struct Request {
      var page:Int
    }
    
    struct Response {
      var reviews: [MovieReviewsMDB]?
      var message: String
    }
    struct ViewModel {
      var reviews: [MovieReviewsMDB]?
      var message: String
    }
  }
  
  enum GetMovieTrailers {
    struct Request {
    }
    
    struct Response {
      var videos: [VideosMDB]?
      var message: String
    }
    struct ViewModel {
      var videos: [VideosMDB]?
      var message: String
    }
  }
}
