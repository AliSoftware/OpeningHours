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

    self.title = L10n.ShopsList.title
    self.navigationItem.rightBarButtonItems = [
      UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewShop))
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

  override func tableView(_ tableView: UITableView,
                          editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let delete = UITableViewRowAction(style: .destructive, title: L10n.ShopsList.delete) { (_, indexPath) in
      self.shops.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }

    let rename = UITableViewRowAction(style: .default, title: L10n.ShopsList.rename) { (_, indexPath) in
      self.prompt(
        title: L10n.Shop.Rename.Prompt.title,
        message: L10n.Shop.Rename.Prompt.message,
        defaultValue: self.shops[indexPath.row].name
      ) { name in
        guard let newName = name else { return }
        self.shops[indexPath.row].name = newName
        self.tableView.reloadData()
      }
    }
    rename.backgroundColor = UIColor.lightGray

    return [delete, rename]
  }

  // MARK: - Private Properties

  private var refreshClock: Clock?

  // MARK: - Private Methods

  @objc
  private func addNewShop() {
    prompt(
      title: L10n.Shop.New.Prompt.title,
      message: L10n.Shop.New.Prompt.message,
      defaultValue: L10n.Shop.New.defaultName
    ) { name in
      guard let shopName = name else { return }
      let newShop = Shop(name: shopName, timeTable: [:])
      self.shops.append(newShop)
      Prefs.main.shops = self.shops
      self.tableView.reloadData()
    }
  }

  private func prompt(title: String, message: String, defaultValue: String, completion: @escaping (String?) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addTextField { $0.text = defaultValue }
    alert.addAction(UIAlertAction(title: L10n.cancel, style: .cancel) { _ in
      completion(nil)
    })
    alert.addAction(UIAlertAction(title: L10n.ok, style: .default) { _ in
      completion(alert.textFields?[0].text ?? "")
    })
    self.present(alert, animated: true, completion: nil)
  }
}
