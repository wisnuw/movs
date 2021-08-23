//
//  WIZListTableViewController.swift
//  movs
//
//  Created by wisnu wardhana on 23/08/21.
//  Copyright © 2021 WIZ. All rights reserved.
//

import UIKit
import TMDBSwift

class WIZListTableViewController: UITableViewController {
  var list:[GenresMDB]!
  var completionHandler: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "listCell")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "listCell")
    }
    
    cell?.textLabel?.text = list[indexPath.row].name
    return cell!
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.dismiss(animated: true) {
      self.completionHandler?(self.list[indexPath.row].id!)
    }
  }
}
