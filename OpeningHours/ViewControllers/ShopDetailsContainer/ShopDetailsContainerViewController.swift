//
//  ShopDetailsViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 26/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class ShopDetailsContainerViewController: UIViewController {

  // MARK: - Public Properties

  var shop: Shop!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = self.shop.name

    let toggleSegment = UISegmentedControl(items: [Asset.timeTableBtn.image, Asset.listBtn.image])
    toggleSegment.addTarget(self, action: #selector(toggleView(_:)), for: .valueChanged)
    toggleSegment.selectedSegmentIndex = Prefs.main.lastSelectedDetailsView

    self.navigationItem.rightBarButtonItems = [
      UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTimeRange)),
      UIBarButtonItem(customView: toggleSegment)
    ]

    toggleView(toggleSegment)
  }

  // MARK: - IBOutlets

  @IBOutlet private var container: UIView!

  // MARK: - Private Properties

  private var currentViewController: (UIViewController & ShopDetailsUI)?
}

// MARK: - Private Methods

private extension ShopDetailsContainerViewController {

  @objc
  func toggleView(_ sender: UISegmentedControl) {
    Prefs.main.lastSelectedDetailsView = sender.selectedSegmentIndex

    var vcToShow: UIViewController & ShopDetailsUI
    switch sender.selectedSegmentIndex {
    case 0: // TimeTable Mode
      vcToShow = StoryboardScene.Main.timeTable.instantiate()
    case 1: // List Mode
      vcToShow = StoryboardScene.Main.timeList.instantiate()
    default:
      fatalError("Unsupported view")
    }
    vcToShow.shop = shop
    self.embed(viewController: vcToShow)
  }

  @objc
  func addTimeRange() {
    let viewCtrl = StoryboardScene.Main.newTimeRangeViewController.instantiate()
    viewCtrl.onValidate = { weekdays, timeRange in
      for days in weekdays {
        var ranges = self.shop?.timeTable[days] ?? []
        ranges.append(timeRange)
        self.shop?.timeTable[days] = ranges
      }
      self.currentViewController?.refresh()
    }
    let navCtrl = UINavigationController(rootViewController: viewCtrl)
    self.present(navCtrl, animated: true, completion: nil)
  }

  func embed(viewController: UIViewController & ShopDetailsUI) {
    if let currentVC = self.currentViewController, currentVC == viewController { return }

    self.currentViewController?.willMove(toParent: nil)
    self.currentViewController?.view.removeFromSuperview()
    self.currentViewController?.removeFromParent()

    self.addChild(viewController)
    self.view.addSubview(viewController.view)
    viewController.didMove(toParent: self)

    self.currentViewController = viewController
  }
}
