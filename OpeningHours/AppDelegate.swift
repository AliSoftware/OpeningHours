//
//  AppDelegate.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    fillDummyValues()
    ///

    let shopsListVC = StoryboardScene.Main.shopsList.instantiate()
    shopsListVC.shops = Prefs.main.shops

    let window = UIWindow()
    let navCtrl = UINavigationController(rootViewController: shopsListVC)
    window.rootViewController = navCtrl
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}

// TODO: Remove dummy values below

extension Time: ExpressibleByFloatLiteral {
  init(floatLiteral value: Double) {
    self.hour = Int(value)
    self.minutes = Int(value*100) % 100
    assert(minutes < 60)
  }
}

extension Time {
  static func - (start: Time, end: Time) -> TimeRange {
    return TimeRange(start: start, end: end)
  }
}

func fillDummyValues() {
  let ranges1: [TimeRange] = [
     9.30 - 12.00,
    13.30 - 15.00,
    18.00 - 20.00
  ]
  let ranges2: [TimeRange] = [
     9.30 - 12.00,
    14.00 - 18.00
  ]
  let ranges3: [TimeRange] = [
    10.00 - 12.00
  ]
  let ranges4: [TimeRange] = [
     0.00 - 12.00,
    14.00 - 20.00
  ]
  let ranges5: [TimeRange] = [
     0.00 -  6.40
  ]
  let shop1 = Shop(name: "Boulangerie", timeTable: [
    .monday: ranges1, .tuesday: ranges1, .wednesday: ranges2, .thursday: ranges1, .friday: ranges1, .saturday: ranges3
    ])
  let shop2 = Shop(name: "Poissonnerie Jahier", timeTable: [
    .tuesday: ranges1, .wednesday: ranges2, .thursday: ranges1, .friday: ranges1, .saturday: ranges3, .sunday: ranges4
    ])
  let shop3 = Shop(name: "Jardiland", timeTable: [
    .tuesday: ranges1, .wednesday: ranges2, .thursday: ranges1, .friday: ranges1, .saturday: ranges3, .sunday: ranges5
    ])

  Prefs.main.shops = [shop1, shop2, shop3]
  Prefs.main.registerDefaults()
}
