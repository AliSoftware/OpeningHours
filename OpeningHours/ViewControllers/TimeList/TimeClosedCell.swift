//
//  TimeClosedCell.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 28/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

class TimeClosedCell: UITableViewCell, Reusable {
  @IBOutlet var closedLabel: UILabel! {
    didSet {
      closedLabel.text = L10n.shopClosed
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    let size: CGFloat = 16
    let square = CGSize(width: size, height: size)
    let stripesImage = UIGraphicsImageRenderer(size: square).image {
      let ctx = $0.cgContext
      ctx.setFillColor(UIColor.white.cgColor)
      ctx.fill(CGRect(origin: .zero, size: square))
      ctx.setStrokeColor(UIColor(white: 0.9, alpha: 1.0).cgColor)
      ctx.setLineWidth(size*3/8)
      ctx.strokeLineSegments(between: [
        CGPoint(x: 0, y: size), CGPoint(x: size, y: 0),
        CGPoint(x: -size, y: size), CGPoint(x: size, y: -size),
        CGPoint(x: 0, y: 2*size), CGPoint(x: 2*size, y: 0)
      ])
    }
    self.contentView.backgroundColor = UIColor(patternImage: stripesImage)
  }
}
