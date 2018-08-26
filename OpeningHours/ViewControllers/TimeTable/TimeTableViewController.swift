//
//  TimeTableViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {
  // MARK: - IBOutlets

  @IBOutlet private var timesContainerView: UIView!
  @IBOutlet private var weekdayViews: [WeekdayView] = []

  // MARK: - Public Properties

  var timeTable: TimeTable = [:]
  var timer: Timer?

  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.configure(with: timeTable)
    self.setupUI()

    self.timer?.invalidate()
    self.timer = Timer(timeInterval: 5*60, repeats: true, block: { [weak self] _ in
      self?.setCurrentTime(to: Weekday.today, at: Time.now)
    })
    self.setCurrentTime(to: Weekday.today, at: Time.now)
  }

  deinit {
    timer?.invalidate()
  }

  override func viewDidLayoutSubviews() {
    let size = self.timesContainerView.bounds.size
    let step = size.height / CGFloat(self.timeViews.count - 1)
    for (idx, pair) in self.timeViews.enumerated() {
      let yPosition = CGFloat(idx) * step
      let timeFrame = self.timesContainerView.frame
      pair.label.frame = CGRect(
        x: 0,
        y: yPosition - step/2,
        width: size.width,
        height: step
      )
      pair.line.frame = CGRect(
        x: timeFrame.maxX,
        y: timeFrame.minY + yPosition,
        width: self.view.bounds.size.width - timeFrame.maxX,
        height: 1
      )
    }
    super.viewDidLayoutSubviews()
  }

  // MARK: - Private Properties

  private var timeViews: [(label: UILabel, line: UIView)] = []

  // MARK: - Private Methods

  private func configure(with timeTable: TimeTable) {
    for view in weekdayViews {
      guard let weekday = Weekday(rawValue: view.tag) else { continue }
      guard let ranges = timeTable[weekday] else { continue }
      view.configure(ranges: ranges, style: .timeRange)
    }
  }

  private func setupUI() {
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
      self.view.addSubview(pair.line)
    }

    self.weekdayViews.forEach({
      ViewStyle.lightFrame.apply(to: $0)
    })
  }

  private func setCurrentTime(to weekday: Weekday, at time: Time) {
    for view in self.weekdayViews {
      view.currentTime = view.tag == weekday.rawValue ? time : nil
    }
  }
}
