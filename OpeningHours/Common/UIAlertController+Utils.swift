//
//  UIAlertController+Utils.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 04/09/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func confirm(title: String, message: String, destructive: Bool = false, completion: @escaping (Bool) -> Void) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: L10n.cancel, style: .cancel) { _ in
      completion(false)
    })
    alert.addAction(UIAlertAction(title: L10n.ok, style: destructive ? .destructive : .default) { _ in
      completion(true)
    })
    return alert
  }

  static func prompt(title: String, message: String, defaultValue: String, completion: @escaping (String?) -> Void) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addTextField { $0.text = defaultValue }
    alert.addAction(UIAlertAction(title: L10n.cancel, style: .cancel) { _ in
      completion(nil)
    })
    alert.addAction(UIAlertAction(title: L10n.ok, style: .default) { _ in
      completion(alert.textFields?[0].text ?? "")
    })
    return alert
  }

  static func present(on viewController: UIViewController, _ alert: UIAlertController) {
    alert.present(on: viewController)
  }

  func present(on viewController: UIViewController) {
    viewController.present(self, animated: true, completion: nil)
  }
}
