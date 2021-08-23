//
//  WIZHomeModels.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

enum WIZHome {
  struct Movie {
    var id:String
    var title:String
  }
  
  enum GetMovies {
    struct Request {
      var query: String
    }
    struct Response {
      var movieList: [Movie]?
      var message: String
    }
    struct ViewModel {
      var movieList: [Movie]?
      var message: String
    }
  }
}
