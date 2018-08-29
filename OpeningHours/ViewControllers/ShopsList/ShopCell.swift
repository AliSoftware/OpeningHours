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
      if timeLeft <= Prefs.main.closingSoonThreshold {
        statusView.backgroundColor = .orange
        nextTimeRange.text = "\(activeTimeRange) — \(L10n.Shop.State.closingSoon(timeLeft))"
      } else {
        statusView.backgroundColor = .green
        nextTimeRange.text = "\(activeTimeRange) — \(L10n.Shop.State.open)"
      }
    } else {
      statusView.backgroundColor = .red
      if let nextOpeningRange = shop.nextTimeRange() {
        let nextOpening = L10n.Shop.State.nextOpening(nextOpeningRange.start.description)
        nextTimeRange.text = "\(L10n.Shop.State.closed) — \(nextOpening)"
      } else {
        nextTimeRange.text = L10n.Shop.State.closed
      }
    }
  }
}
