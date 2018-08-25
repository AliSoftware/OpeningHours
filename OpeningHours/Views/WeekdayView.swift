//
//  WeekdayView.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class WeekdayView: UIView {
  private var rangeViews: [(view: UIView, range: TimeRange)] = []

  private static let timeViewHeight: CGFloat = 3.0
  private let currentTimeView: UIView = {
    let view = UIView()
    ViewStyle(
      backgroundColor: UIColor.red.withAlphaComponent(0.4),
      borderColor: .red,
      borderWidth: 1,
      cornerRadius: WeekdayView.timeViewHeight/2
    ).apply(to: view)
    return view
  }()

  var currentTime: Time? {
    didSet {
      updateCurrentTime()
    }
  }

  func configure(ranges: [TimeRange], style: ViewStyle) {
    self.rangeViews.forEach { $0.view.removeFromSuperview() }
    let pairs = ranges.map { (range: TimeRange) -> (UIView, TimeRange) in
      let view = UIView()
      style.apply(to: view)
      return (view, range)
    }
    self.rangeViews = pairs
    self.rangeViews.forEach { self.addSubview($0.view) }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(currentTimeView)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addSubview(currentTimeView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    let size = self.bounds.size
    let scale = size.height / CGFloat(Time.max)

    for (view, range) in rangeViews {
      view.frame = CGRect(
        x: 0,
        y: CGFloat(range.start.totalMinutes) * scale,
        width: size.width,
        height: CGFloat(range.durationInMinutes) * scale
      )
    }

    updateCurrentTime()
  }

  func apply(style: ViewStyle, currentTimeStyle: ViewStyle) {
    rangeViews.forEach {
      style.apply(to: $0.view)
    }
    style.apply(to: self.currentTimeView)
  }

  func updateCurrentTime() {
    guard let time = self.currentTime else {
      self.currentTimeView.isHidden = true
      return
    }

    let size = self.bounds.size
    let scale = size.height / CGFloat(Time.max)
    let yPosition = CGFloat(time.totalMinutes) * scale

    self.currentTimeView.frame = CGRect(
      x: 0,
      y: yPosition - WeekdayView.timeViewHeight/2,
      width: size.width,
      height: WeekdayView.timeViewHeight
    )
    self.currentTimeView.isHidden = false
    self.bringSubviewToFront(self.currentTimeView)
  }

  // TODO: Implement UIMenuController to show details of each TimeRange view
  // https://nshipster.com/uimenucontroller/
}
