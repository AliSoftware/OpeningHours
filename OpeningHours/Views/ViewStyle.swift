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
