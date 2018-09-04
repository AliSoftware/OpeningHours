//
//  TimeRowCell.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 28/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

class TimeRowCell: UITableViewCell, Reusable {

  // MARK: - Setup

  func setup(day: Weekday, timeRange: TimeRange) {
    self.timeLabel.text = timeRange.description
    let isActive = day == .today && timeRange.contains(.now)
    self.activeIndicator.isHidden = !isActive
    self.contentView.backgroundColor = isActive ? UIColor.green.withAlphaComponent(0.1) : .white
  }

  // MARK: - IBOutlet

  @IBOutlet private var timeLabel: UILabel!
  @IBOutlet private var activeIndicator: UIView!
}
