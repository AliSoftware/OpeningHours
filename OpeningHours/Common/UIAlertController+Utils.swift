//
//  UIAlertController+Utils.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 04/09/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func confirm(
    title: String,
    message: String,
    destructive: Bool = false,
    completion: @escaping (Bool) -> Void
  ) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: L10n.cancel, style: .cancel) { _ in
      completion(false)
    })
    alert.addAction(UIAlertAction(title: L10n.ok, style: destructive ? .destructive : .default) { _ in
      completion(true)
    })
    return alert
  }
}
