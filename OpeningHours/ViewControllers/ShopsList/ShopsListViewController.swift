//
//  FirstViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class ShopsListViewController: UITableViewController {
  // MARK: - Public Properties

  var shops: [Shop] = []

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = L10n.shopListTitle
    self.navigationItem.rightBarButtonItems = [
      UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditMode))
    ]

    self.refreshClock = Clock { [weak self] in
      self?.tableView.reloadData() // To update open/close status on each cell
    }
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shops.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as ShopCell
    let shop = shops[indexPath.row]
    cell.setup(shop: shop)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let container = StoryboardScene.Main.shopDetails.instantiate()
    let shop = shops[indexPath.row]
    container.title = shop.name
    container.timeTable = shop.timeTable
    self.navigationController?.pushViewController(container, animated: true)
  }

  // MARK: - Private Properties

  private var refreshClock: Clock?

  // MARK: - Private Methods

  @objc
  private func toggleEditMode() {
//    self.tableView.isEditing = !self.tableView.isEditing
    // TODO: Implement this
    // Don't forget to add a "+" button
    print(#function)
  }
}
