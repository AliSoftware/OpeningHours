//
//  ShopCell.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

class ShopCell: UITableViewCell, Reusable {
  // MARK: - IBOutlets

  @IBOutlet var statusView: UIView!
  @IBOutlet var shopNameLabel: UILabel!
  @IBOutlet var nextTimeRange: UILabel!

  // MARK: - Public Methods
  
  func setup(shop: Shop) {
    shopNameLabel.text = shop.name
    let activeTimeRange = shop.activeTimeRange()
    if let activeTimeRange = activeTimeRange {
      let timeLeft = activeTimeRange.minutesRemaining()
      if timeLeft < 30 {
        statusView.backgroundColor = .orange
        nextTimeRange.text = "\(activeTimeRange) — \(L10n.shopClosingSoon(timeLeft))"
      } else {
        statusView.backgroundColor = .green
        nextTimeRange.text = "\(activeTimeRange) — \(L10n.shopOpen)"
      }
    } else {
      statusView.backgroundColor = .red
      nextTimeRange.text = L10n.shopClosed
    }
  }
}
