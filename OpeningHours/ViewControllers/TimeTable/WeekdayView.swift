//
//  WeekdayView.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class WeekdayView: UIView {
  // MARK: - Public Properties

  var currentTime: Time? {
    didSet {
      updateCurrentTime()
    }
  }

  // MARK: - Setup

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  // MARK: - LifeCycle

  override func layoutSubviews() {
    super.layoutSubviews()
    let size = self.bounds.size
    let scale = size.height / CGFloat(Time.max)

    for slotView in slotViews {
      slotView.frame = CGRect(
        x: slotView.layer.borderWidth,
        y: CGFloat(slotView.range.start.totalMinutes) * scale,
        width: size.width - 2*slotView.layer.borderWidth,
        height: CGFloat(slotView.range.durationInMinutes) * scale
      )
    }

    updateCurrentTime()
  }

  // MARK: - Public Methods

  func configure(ranges: [TimeRange], style: ViewStyle) {
    self.slotViews.forEach { $0.removeFromSuperview() }
    self.slotViews = ranges.map { (range: TimeRange) -> SlotView in
      let view = SlotView(range: range)
      let tapGR = UITapGestureRecognizer(target: self, action: #selector(showMenu(_:)))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tapGR)
      style.apply(to: view)
      return view
    }
    self.slotViews.forEach { self.addSubview($0) }
  }

  // MARK: - Private Properties

  private var slotViews: [SlotView] = []
  private static let timeViewHeight: CGFloat = 3.0
  private let currentTimeView: UIView = {
    let view = UIView()
    ViewStyle.nowIndicator.apply(to: view)
    return view
  }()

  // MARK: - Private Methods

  private func setup() {
    self.addSubview(currentTimeView)
  }

  private func updateCurrentTime() {
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

  @objc
  private func showMenu(_ sender: UITapGestureRecognizer) {
    guard let tappedView = sender.view, let superView = tappedView.superview else {
      return
    }
    guard let range = slotViews.first(where: { $0 == tappedView })?.range else {
      return
    }
    let menuController = UIMenuController.shared
    menuController.menuItems = [UIMenuItem(title: range.description, action: #selector(SlotView.displayTimeRange(_:)))]
    tappedView.becomeFirstResponder()
    menuController.setTargetRect(tappedView.frame, in: superView)
    menuController.setMenuVisible(true, animated: true)
  }
}
