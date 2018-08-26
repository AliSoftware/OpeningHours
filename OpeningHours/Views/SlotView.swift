//
//  SlotView.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 26/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class SlotView: UIView {
  // MARK: - Public Properties

  let range: TimeRange

  // MARK: - Setup

  init(range: TimeRange) {
    self.range = range
    super.init(frame: .zero)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    self.range = TimeRange(start: Time(totalMinutes: 0), end: Time(totalMinutes: 0))
    super.init(frame: .zero)
  }

  // MARK: - UIMenuController Support

  override var canBecomeFirstResponder: Bool {
    return true
  }
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return action == #selector(displayTimeRange(_:))
  }
  @objc func displayTimeRange(_ sender: Any) {}
}
