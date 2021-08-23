//
//  ViewController.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift

protocol WIZHomeDisplayLogic: class {
  func displayGetMovies(viewModel:WIZHome.GetMovies.ViewModel)
  func displayGetGenres(viewModel:WIZHome.GetGenres.ViewModel)
}

class WIZHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var router: WIZHomeRouterLogic?
  var interactor: WIZHomeBusinessLogic?
  var movies: [MovieMDB]?
  var pageCount:Int = 1
  var isMovieStillExisted:Bool = true
  
  var tableView: UITableView  = {
    let tableView = UITableView()
    tableView.backgroundColor = UIColor.yellow
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    interactor?.getMovies(request: WIZHome.GetMovies.Request(genreId: nil, page: self.pageCount))
    setupView()
  }
  
  func setupView() {
    self.title = "movs"
    self.view.backgroundColor = .white
    
    let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(didTapGenresButton(sender:)))
    btn.title = "Genres"
    self.navigationItem.rightBarButtonItem = btn
    
    self.view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
  
  @objc func didTapGenresButton(sender: AnyObject) {
    interactor?.getGenres(request: WIZHome.GetGenres.Request())
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let movieId = movies?[indexPath.row].id {
      router?.presentMovieDetail(movieId: movieId)
    }
    else {
      print("Movie id not existed")
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    }
    
    cell?.textLabel?.text = movies?[indexPath.row].title
    return cell!
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row + 1 == movies?.count && isMovieStillExisted {
      self.pageCount += 1
      interactor?.getMovies(request: WIZHome.GetMovies.Request(genreId: nil, page: self.pageCount))
    }
  }
}

extension WIZHomeViewController: WIZHomeDisplayLogic {
  func displayGetMovies(viewModel:WIZHome.GetMovies.ViewModel) {
    if self.pageCount == 1 {
      movies = [MovieMDB]()
    }
    
    if let movs = viewModel.movieList, movs.count > 0 {
      movies?.append(contentsOf: movs)
    }
    else {
      self.isMovieStillExisted = false
    }
    self.tableView.reloadData()
  }
  
  func displayGetGenres(viewModel:WIZHome.GetGenres.ViewModel) {
    router?.presentGenreList(list: viewModel.genres ?? [], completionHandler: { (genreId) in
      self.pageCount = 1
      self.isMovieStillExisted = true
      self.interactor?.getMovies(request: WIZHome.GetMovies.Request(genreId: genreId, page: self.pageCount))
    })
  }
}

