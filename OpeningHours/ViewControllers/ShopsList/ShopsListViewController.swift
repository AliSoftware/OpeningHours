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
    self.navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: L10n.About.button, style: .plain, target: self, action: #selector(about))
    self.navigationItem.rightBarButtonItems = [
      UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewShop(_:))),
      self.editButtonItem
    ]

    self.refreshClock = Clock { [weak self] in
      self?.tableView.reloadData() // To update open/close status on each cell
    }

    // UIViewControllerPreviewingDelegate (3D Touch Peek & Pop)
    registerForPreviewing(with: self, sourceView: self.tableView)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData() // To update open/close status on each cell in case it was edited since
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
    let container = createDetailsContainer(indexPath: indexPath)
    self.navigationController?.pushViewController(container, animated: true)
  }

  override func tableView(_ tableView: UITableView,
                          editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    return [
      self.deleteRowAction(for: indexPath),
      self.renameRowAction(for: indexPath)
    ]
  }

  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    let movedShop = self.shops.remove(at: sourceIndexPath.row)
    self.shops.insert(movedShop, at: destinationIndexPath.row)
  }

  // MARK: - Private Properties

  private var refreshClock: Clock?
}

// MARK: - Private Methods

private extension ShopsListViewController {

  func deleteRowAction(for indexPath: IndexPath) -> UITableViewRowAction {
    let shop = self.shops[indexPath.row]
    let action = UITableViewRowAction(style: .destructive, title: L10n.ShopsList.delete) { (_, indexPath) in
      let alert = UIAlertController.confirm(
        title: L10n.Delete.Alert.title,
        message: L10n.Delete.Alert.message(shop.name, shop.details),
        destructive: true
      ) { confirmed in
        guard confirmed else { return }
        self.shops.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
      }
      self.present(alert, animated: true, completion: nil)
    }
    return action
  }

  func renameRowAction(for indexPath: IndexPath) -> UITableViewRowAction {
    let action = UITableViewRowAction(style: .default, title: L10n.ShopsList.rename) { (_, indexPath) in
      let shopInfoVC = StoryboardScene.Main.shopInfoViewController.instantiate()
      let rect = self.tableView.rectForRow(at: indexPath)
      shopInfoVC.configurePresentation(sourceView: self.tableView, sourceRect: rect) { shopInfo in
        guard let info = shopInfo else { return }
        let shop = self.shops[indexPath.row]
        shop.icon = info.icon.map(String.init) ?? ""
        shop.name = info.name
        shop.details = info.details
        self.tableView.reloadData()
      }
      shopInfoVC.prefill(with: self.shops[indexPath.row])
      self.present(shopInfoVC, animated: true, completion: nil)
    }
    action.backgroundColor = UIColor.lightGray
    return action
  }

  @objc
  func about() {
    let aboutVC = StoryboardScene.Main.about.instantiate()
    aboutVC.title = L10n.About.title
    aboutVC.navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: L10n.ok, style: .plain, target: self, action: #selector(dismissAbout))
    let navCtrl = UINavigationController(rootViewController: aboutVC)
    self.present(navCtrl, animated: true, completion: nil)
  }

  @objc
  func dismissAbout() {
    self.dismiss(animated: true, completion: nil)
  }

  @objc
  func addNewShop(_ sender: UIBarButtonItem) {
    let shopInfoVC = StoryboardScene.Main.shopInfoViewController.instantiate()
    shopInfoVC.configurePresentation(barButtonItem: sender) { shopInfo in
      guard let info = shopInfo else { return }
      let newShop = Shop(icon: info.icon, name: info.name, details: info.details)
      self.shops.append(newShop)
      self.tableView.reloadData()
    }
    self.present(shopInfoVC, animated: true, completion: nil)
  }

  func createDetailsContainer(indexPath: IndexPath) -> UIViewController {
    let container = StoryboardScene.Main.shopDetails.instantiate()
    let shop = shops[indexPath.row]
    container.shop = shop
    return container
  }
}

// MARK: - UITableViewControllerPreviewingDelegate

extension ShopsListViewController: UIViewControllerPreviewingDelegate {
  public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                                viewControllerForLocation location: CGPoint) -> UIViewController? {
    guard let indexPath = tableView.indexPathForRow(at: location) else {
      return nil
    }
    let detailViewController = createDetailsContainer(indexPath: indexPath)
    return detailViewController
  }

  public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                                commit viewControllerToCommit: UIViewController) {
    navigationController?.pushViewController(viewControllerToCommit, animated: true)
  }
}
