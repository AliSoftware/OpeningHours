//
//  TimeTableViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {
  @IBOutlet private var timesContainerView: UIView!
  @IBOutlet private var weekdayViews: [UIView]!
  private var timeViews: [(label: UILabel, line: UIView)] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // Create timeLabels
    self.timeViews = (0...24).map { hour in
      let label = UILabel()
      label.backgroundColor = .white
      label.textColor = .black
      label.text = "\(hour)h"
      label.font = .systemFont(ofSize: 10)
      label.textAlignment = .right
      label.sizeToFit()

      let line = UIView()
      line.backgroundColor = .gray

      return (label, line)
    }
    for pair in self.timeViews {
      self.view.addSubview(pair.label)
      self.view.addSubview(pair.line)
    }
  }

  override func viewDidLayoutSubviews() {
    let sz = self.timesContainerView.bounds.size
    let step = sz.height / CGFloat(self.timeViews.count - 1)
    for (idx, pair) in self.timeViews.enumerated() {
      let y = CGFloat(idx) * step
      pair.label.frame = CGRect(x: 0, y: y - step/2, width: sz.width, height: step)
      pair.line.frame = CGRect(x: 0, y: y, width: sz.width, height: 1)
    }
    super.viewDidLayoutSubviews()
  }

}

