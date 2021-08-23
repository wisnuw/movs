//
//  ViewController.swift
//  movs
//
//  Created by wisnu wardhana on 21/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift
import WebKit

protocol WIZMovieDetailDisplayLogic: class {
  func displayGetMovieReviews(viewModel:WIZMovieDetail.GetMovieReviews.ViewModel)
  func displayGetMovieDetail(viewModel:WIZMovieDetail.GetMovieDetail.ViewModel)
  func displayGetMovieTrailers(viewModel:WIZMovieDetail.GetMovieTrailers.ViewModel)
}

class WIZMovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var router: WIZMovieDetailRouterLogic?
  var interactor: WIZMovieDetailBusinessLogic?
  var videos:[VideosMDB]?
  var detail:MovieDetailedMDB?
  var reviews:[MovieReviewsMDB]?
  var webView: WKWebView?
  var reviewPageCount:Int = 1
  var isReviewStillExist:Bool = true
  
  var tableView: UITableView  = {
    let tableView = UITableView()
    tableView.backgroundColor = UIColor.yellow
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    interactor?.getMovieDetail(request: WIZMovieDetail.GetMovieDetail.Request())
    interactor?.getMovieReviews(request: WIZMovieDetail.GetMovieReviews.Request(page: self.reviewPageCount))
    interactor?.getMovieTrailers(request: WIZMovieDetail.GetMovieTrailers.Request())
    
    setupView()
  }
  
  func setupView() {
    self.title = "Loading..."
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
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return 1
    }
    else if section == 1 {
      return 1
    }
    else {
      return self.reviews?.count ?? 0
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Trailer"
    }
    else if section == 1 {
      return "Detail"
    }
    else {
      return "Reviews"
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    }
    
    if indexPath.section == 0 {
      cell?.textLabel?.text = "Play Video Trailer"
    }
    else if indexPath.section == 1 {
      cell?.textLabel?.text = detail?.original_title
    }
    else {
      cell?.textLabel?.text = "@\(reviews?[indexPath.row].author ?? "No Author") :\n\(reviews?[indexPath.row].content ?? "No Review")"
      cell?.textLabel?.numberOfLines = 0
    }
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0, let youtubeKey = videos?[0].key {
      // Create Video player
      let mywkwebviewConfig = WKWebViewConfiguration()
      mywkwebviewConfig.allowsInlineMediaPlayback = true
      
      webView = WKWebView(frame: self.view.frame, configuration: mywkwebviewConfig)
      
      let myURL = URL(string: "https://www.youtube.com/embed/\(youtubeKey)?playsinline=1?autoplay=1")
      let youtubeRequest = URLRequest(url: myURL!)
      
      webView?.load(youtubeRequest)
      
      guard let webView = webView else { return }
      self.view.addSubview(webView)
      
      let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(didTapClose(sender:)))
      self.navigationItem.rightBarButtonItem = btn
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.section == 2 && indexPath.row + 1 == reviews?.count && isReviewStillExist {
      self.reviewPageCount += 1
      interactor?.getMovieReviews(request: WIZMovieDetail.GetMovieReviews.Request(page: self.reviewPageCount))
    }
  }
  
  @objc func didTapClose(sender: AnyObject) {
    self.webView?.removeFromSuperview()
    self.webView = nil
    self.navigationItem.rightBarButtonItem = nil
  }
  
}

extension WIZMovieDetailViewController: WIZMovieDetailDisplayLogic {
  func displayGetMovieReviews(viewModel:WIZMovieDetail.GetMovieReviews.ViewModel) {
    if self.reviewPageCount == 1 {
      self.reviews = [MovieReviewsMDB]()
    }
    
    if let revs = viewModel.reviews, revs.count > 0 {
      self.reviews?.append(contentsOf: revs)
    }
    else {
      isReviewStillExist = false
    }
    
    self.tableView.reloadData()
  }
  
  func displayGetMovieDetail(viewModel:WIZMovieDetail.GetMovieDetail.ViewModel) {
    self.title = viewModel.detail?.title
    self.detail = viewModel.detail
    self.tableView.reloadData()
  }
  
  func displayGetMovieTrailers(viewModel: WIZMovieDetail.GetMovieTrailers.ViewModel) {
    self.videos = viewModel.videos
    self.tableView.reloadData()
  }
  
}

