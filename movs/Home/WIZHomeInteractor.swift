//
//  WIZHomeInteractor.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift

protocol WIZHomeBusinessLogic
{
  func getMovies(request:WIZHome.GetMovies.Request)
  func getGenres(request:WIZHome.GetGenres.Request)
}

class WIZHomeInteractor: WIZHomeBusinessLogic {
  var presenter: WIZHomePresentationLogic?
  var data: [MovieMDB]!
  var genres: [GenresMDB]!
  var selectedGenreId: Int?
  
  func getMovies(request:WIZHome.GetMovies.Request) {
    self.selectedGenreId = request.genreId
    var params = [DiscoverParam.page(request.page),DiscoverParam.language("en")]
    if let id = self.selectedGenreId {
      params.append(DiscoverParam.with_genres("\(id)"))
    }
    
    MovieMDB.discoverMovies(params: params, completion: { api, movie in
      var message:String = ""
      if let error = api.error {
        self.data = []
        message = error.localizedDescription
      }
      else {
        self.data = movie
      }
      
      let response = WIZHome.GetMovies.Response(movieList: self.data, message: message)
      self.presenter?.presentGetMovies(response: response)
    })
  }
  
  func getGenres(request:WIZHome.GetGenres.Request) {
    GenresMDB.genres(listType: GenresListType.movie, language: "en") { (api, genres) in
      var message:String = ""
      if let error = api.error {
        self.genres = []
        message = error.localizedDescription
      }
      else {
        self.genres = genres
      }
      
      let response = WIZHome.GetGenres.Response(genres: self.genres, message: message)
      self.presenter?.presentGetGenres(response: response)
    }
  }
  
}
