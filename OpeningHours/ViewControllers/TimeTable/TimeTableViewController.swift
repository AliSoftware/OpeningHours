//
//  TimeTableViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {

  // MARK: - Public Properties

  var shop: Shop!

  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.configure(with: self.shop.timeTable)
    self.setupUI()

    self.refreshClock = Clock { [weak self] in
      self?.setCurrentTime(to: Weekday.today, at: Time.now)
    }
    self.setCurrentTime(to: Weekday.today, at: Time.now)
  }

  override func viewDidLayoutSubviews() {
    let size = self.timesContainerView.bounds.size
    let step = size.height / CGFloat(self.timeViews.count - 1)
    for (idx, pair) in self.timeViews.enumerated() {
      let top = self.weekdayViews.first?.frame.minY ?? 0
      let yPosition = CGFloat(idx) * step
      pair.label.frame = CGRect(
        x: 0,
        y: yPosition - step/2,
        width: size.width,
        height: step
      )
      pair.line.frame = CGRect(
        x: 0,
        y: top + yPosition,
        width: self.columnsStackView.bounds.size.width,
        height: 1
      )
    }
    super.viewDidLayoutSubviews()
  }

  // MARK: - IBOutlets

  @IBOutlet private var timesContainerView: UIView!
  @IBOutlet private var columnsStackView: UIStackView!
  @IBOutlet private var weekdayLabels: [UILabel] = []
  @IBOutlet private var weekdayViews: [WeekdayView] = []

  // MARK: - Private Properties

  private var timeViews: [(label: UILabel, line: UIView)] = []
  private var refreshClock: Clock?
}

// MARK: - Private Methods

private extension TimeTableViewController {

  func configure(with timeTable: TimeTable) {
    for (idx, view) in weekdayViews.enumerated() {
      let weekday = Weekday.ordered()[idx]
      view.configure(ranges: timeTable[weekday])
    }
  }

  func setupUI() {
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
      self.timesContainerView.addSubview(pair.label)
      self.columnsStackView.insertSubview(pair.line, at: 0)
    }

    for (idx, label) in self.weekdayLabels.enumerated() {
      label.text = Weekday.ordered()[idx].localizedShortName
    }

    self.weekdayViews.forEach {
      ViewStyle.lightFrame.apply(to: $0)
    }
  }

  func setCurrentTime(to weekday: Weekday, at time: Time) {
    for (view, day) in zip(self.weekdayViews, Weekday.ordered()) {
      view.currentTime = day == weekday ? time : nil
    }
  }
}

// MARK: - ShopDetailsUI

extension TimeTableViewController: ShopDetailsPresenter {
  func refresh() {
    self.configure(with: self.shop.timeTable)
  }
}
