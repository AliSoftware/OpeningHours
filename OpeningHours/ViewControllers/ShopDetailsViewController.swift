//
//  ShopDetailsViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 26/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class ShopDetailsViewController: UIViewController {
  @IBOutlet private var container: UIView!

  private var currentViewController: UIViewController?
  var timeTable: TimeTable = [:]

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.rightBarButtonItems = [
      // TODO: Provide some nice icons
      UIBarButtonItem(title: "Table", style: .plain, target: self, action: #selector(showTable)),
      UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(showList)),
      UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showEdit))
    ]

    showTable()
  }

  @objc
  private func showTable() {
    let tableVC = StoryboardScene.Main.timeTable.instantiate()
    tableVC.timeTable = timeTable
    self.embed(viewController: tableVC)
  }

  @objc
  private func showList() {
    // TODO: Implement this
    print(#function)
  }

  @objc
  private func showEdit() {
    // TODO: Implement this
    print(#function)
  }

  private func embed(viewController: UIViewController) {
    self.currentViewController?.willMove(toParent: nil)
    self.currentViewController?.view.removeFromSuperview()
    self.currentViewController?.removeFromParent()

    self.addChild(viewController)
    self.view.addSubview(viewController.view)
    viewController.didMove(toParent: self)

    self.currentViewController = viewController
  }
}
