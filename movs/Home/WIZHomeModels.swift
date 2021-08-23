//
//  WIZHomeModels.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import TMDBSwift

enum WIZHome {
  enum GetMovies {
    struct Request {
      var genreId:Int?
      var page:Int
    }
    struct Response {
      var movieList: [MovieMDB]?
      var message: String
    }
    struct ViewModel {
      var movieList: [MovieMDB]?
      var message: String
    }
  }
  
  enum GetGenres {
    struct Request {
    }
    
    struct Response {
      var genres: [GenresMDB]?
      var message: String
    }
    struct ViewModel {
      var genres: [GenresMDB]?
      var message: String
    }
  }
}
