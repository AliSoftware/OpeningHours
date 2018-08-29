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

  func setup(timeRange: TimeRange) {
    self.timeLabel.text = timeRange.description
  }

  // MARK: - IBOutlet

  @IBOutlet private var timeLabel: UILabel!
}
