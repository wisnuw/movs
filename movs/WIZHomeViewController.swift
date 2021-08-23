//
//  ViewController.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit

protocol WIZHomeDisplayLogic: class {
  func displayGetMovies(viewModel:WIZHome.GetMovies.ViewModel)
}

class WIZHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    }
    
    cell?.textLabel?.text = movies?[indexPath.row].title
    return cell!
  }
  
  var router: WIZHomeRouterLogic?
  var interactor: WIZHomeBusinessLogic?
  var movies: [WIZHome.Movie]?
  
  var tableView: UITableView  = {
    let tableView = UITableView()
    tableView.backgroundColor = UIColor.yellow
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    interactor?.getMovies(request: WIZHome.GetMovies.Request(query: ""))
    setupView()
  }
  
  func setupView() {
    self.title = "movs"
    self.view.backgroundColor = .white
    
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
}

extension WIZHomeViewController: WIZHomeDisplayLogic {
  func displayGetMovies(viewModel:WIZHome.GetMovies.ViewModel) {
    movies = viewModel.movieList
    self.tableView.reloadData()
  }
}

