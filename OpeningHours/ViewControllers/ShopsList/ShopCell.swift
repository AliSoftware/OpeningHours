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

  // MARK: - LifeCycle

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    let animationDuration = animated ? 0.3 : 0.0
    if editing {
      UIView.animate(
        withDuration: animationDuration,
        animations: { self.statusView.alpha = 0.0 },
        completion: { _ in self.statusView.isHidden = true }
      )
    } else {
      self.statusView.isHidden = false
      UIView.animate(
        withDuration: animationDuration,
        animations: { self.statusView.alpha = 1.0 }
      )
    }
  }

  // MARK: - Public Methods

  func setup(shop: Shop) {
    shopIconLabel.text = shop.icon
    shopNameLabel.text = "\(shop.name) — \(shop.details)"

    let activeTimeRange = shop.timeTable.activeTimeRange()
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
      if let nextOpeningRange = shop.timeTable.nextTimeRange() {
        let nextOpening = L10n.ShopState.nextOpening(nextOpeningRange.start.description)
        nextTimeRange.text = "\(L10n.ShopState.closed) — \(nextOpening)"
      } else {
        nextTimeRange.text = L10n.ShopState.closed
      }
    }
  }

  // MARK: - IBOutlets

  @IBOutlet private var statusView: UIView!
  @IBOutlet private var shopIconLabel: UILabel!
  @IBOutlet private var shopNameLabel: UILabel!
  @IBOutlet private var nextTimeRange: UILabel!
}
