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

  // MARK: - Public Methods

  func setup(shop: Shop) {
    shopNameLabel.text = shop.name
    let activeTimeRange = shop.activeTimeRange()
    if let activeTimeRange = activeTimeRange {
      let timeLeft = activeTimeRange.minutesRemaining()
      if timeLeft <= Prefs.main.closingSoonThreshold {
        statusView.backgroundColor = .orange
        nextTimeRange.text = "\(activeTimeRange) — \(L10n.ShopState.closingSoon(timeLeft))"
      } else {
        statusView.backgroundColor = .green
        nextTimeRange.text = "\(activeTimeRange) — \(L10n.ShopState.open)"
      }
    } else {
      statusView.backgroundColor = .red
      if let nextOpeningRange = shop.nextTimeRange() {
        let nextOpening = L10n.ShopState.nextOpening(nextOpeningRange.start.description)
        nextTimeRange.text = "\(L10n.ShopState.closed) — \(nextOpening)"
      } else {
        nextTimeRange.text = L10n.ShopState.closed
      }
    }
  }

  // MARK: - IBOutlets

  @IBOutlet private var statusView: UIView!
  @IBOutlet private var shopNameLabel: UILabel!
  @IBOutlet private var nextTimeRange: UILabel!
}
