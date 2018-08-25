//
//  WeekdayView.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class WeekdayView: UIView {
  let rangeViews: [(view: UIView, range: TimeRange)]

  init(frame: CGRect = .zero, ranges: [TimeRange], style: ViewStyle) {
    let pairs = ranges.map { (range: TimeRange) -> (UIView, TimeRange) in
      let view = UIView()
      style.apply(to: view)
      return (view, range)
    }
    self.rangeViews = pairs
    super.init(frame: frame)
    self.rangeViews.forEach { self.addSubview($0.view) }
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("Not implemented")
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
  }

  func apply(style: ViewStyle) {
    rangeViews.forEach {
      style.apply(to: $0.view)
    }
  }
}
