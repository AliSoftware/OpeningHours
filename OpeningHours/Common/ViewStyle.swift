//
//  ViewStyle.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

struct ViewStyle {
  let backgroundColor: UIColor?
  let borderColor: UIColor
  let borderWidth: CGFloat
  let cornerRadius: CGFloat

  func apply(to view: UIView) {
    view.backgroundColor = backgroundColor
    view.layer.borderColor = borderColor.cgColor
    view.layer.borderWidth = borderWidth
    view.layer.cornerRadius = cornerRadius
  }
}

extension ViewStyle {
  static let timeSlot = ViewStyle(
    backgroundColor: UIColor(red: 0.7, green: 0.7, blue: 1.0, alpha: 0.8),
    borderColor: .black,
    borderWidth: 1,
    cornerRadius: 3
  )
  static let lightFrame = ViewStyle(
    backgroundColor: nil,
    borderColor: .lightGray,
    borderWidth: 1,
    cornerRadius: 0
  )
  static let nowIndicator = ViewStyle(
    backgroundColor: UIColor.red.withAlphaComponent(0.4),
    borderColor: .red,
    borderWidth: 1,
    cornerRadius: 1
  )
}
