//
//  ShopDetailsViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 26/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class ShopDetailsContainerViewController: UIViewController {
  // MARK: - IBOutlets

  @IBOutlet private var container: UIView!

  // MARK: - Public Properties

  var shop: Shop!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = self.shop.name

    let toggleSegment = UISegmentedControl(items: [Asset.timeTableBtn.image, Asset.listBtn.image])
    toggleSegment.addTarget(self, action: #selector(toggleView(_:)), for: .valueChanged)
    toggleSegment.selectedSegmentIndex = 0

    self.navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: toggleSegment),
      UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTimeRange))
    ]

    toggleView(toggleSegment)
  }

  // MARK: - Private Properties

  private var currentViewController: UIViewController?

  // MARK: - Private Methods

  @objc
  private func toggleView(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0: // TimeTable Mode
      let tableVC = StoryboardScene.Main.timeTable.instantiate()
      tableVC.shop = shop
      self.embed(viewController: tableVC)
    case 1: // List Mode
      let listVC = StoryboardScene.Main.timeList.instantiate()
      listVC.shop = shop
      self.embed(viewController: listVC)
    default:
      print("Unsupported view")
    }
  }

  @objc
  private func addTimeRange() {
    // TODO: Implement this
    print(#function)
  }

  private func embed(viewController: UIViewController) {
    guard self.currentViewController != viewController else { return }

    self.currentViewController?.willMove(toParent: nil)
    self.currentViewController?.view.removeFromSuperview()
    self.currentViewController?.removeFromParent()

    self.addChild(viewController)
    self.view.addSubview(viewController.view)
    viewController.didMove(toParent: self)

    self.currentViewController = viewController
  }
}
