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
  let shopsListVC = StoryboardScene.Main.shopsList.instantiate()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    Prefs.main.registerDefaults()
    shopsListVC.shops = Prefs.main.shops

    let window = UIWindow()
    let navCtrl = UINavigationController(rootViewController: shopsListVC)
    window.rootViewController = navCtrl
    window.makeKeyAndVisible()
    self.window = window

    return true
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    Prefs.main.shops = shopsListVC.shops
  }
}
