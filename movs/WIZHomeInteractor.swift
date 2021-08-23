//
//  WIZHomeInteractor.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit

protocol WIZHomeBusinessLogic
{
  func getMovies(request:WIZHome.GetMovies.Request)
}

class WIZHomeInteractor: WIZHomeBusinessLogic {
  var presenter: WIZHomePresentationLogic?
  
  func getMovies(request:WIZHome.GetMovies.Request) {
    let movie1 = WIZHome.Movie(id: "1", title: "Title 1")
    let movie2 = WIZHome.Movie(id: "2", title: "Title 2")
    let movie3 = WIZHome.Movie(id: "3", title: "Title 3")
    let movie4 = WIZHome.Movie(id: "4", title: "Title 4")
    let response = WIZHome.GetMovies.Response(movieList: [movie1,movie2,movie3,movie4], message: "success")
    self.presenter?.presentGetMovies(response: response)
  }
}
