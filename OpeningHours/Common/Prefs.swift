//
//  Store.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct Prefs {
  // MARK: - Public Type Properties

  static let main = Prefs(defaults: .standard)

  var shops: [Shop] {
    get {
      guard let data = self.defaults.data(forKey: Prefs.Keys.shops) else {
        return []
      }
      let decoder = JSONDecoder()
      do {
        return try decoder.decode([Shop].self, from: data)
      } catch {
        print("Unable to decode shops from UserDefaults")
        return []
      }
    }
    nonmutating set {
      let encoder = JSONEncoder()
      do {
        let data = try encoder.encode(newValue)
        self.defaults.set(data, forKey: Prefs.Keys.shops)
      } catch {
        print("Unable to encode shops to UserDefaults")
      }
    }
  }

  /// ClosingSoon threshold, in minutes
  ///
  /// If minutes before closing is less than this threshold, the shop will be considered to be in state "closing soon"
  var closingSoonThreshold: Int {
    get {
      return self.defaults.integer(forKey: Prefs.Keys.closingSoonThreshold)
    }
    nonmutating set {
      self.defaults.set(newValue, forKey: Prefs.Keys.closingSoonThreshold)
    }
  }

  // MARK: - Setup

  init(defaults: UserDefaults) {
    self.defaults = defaults
  }

  func registerDefaults() {
    guard let settingsBundle = Bundle.main.url(forResource: "Settings", withExtension: "bundle") else {
      return
    }
    guard let settings = NSDictionary(contentsOf: settingsBundle.appendingPathComponent("Root.plist")) else {
      return
    }
    guard let specifiers = settings.object(forKey: "PreferenceSpecifiers") as? [[String: AnyObject]] else {
      return
    }

    var defaultsToRegister = [String: AnyObject]()
    for spec in specifiers {
      if let key = spec["Key"] as? String, let value = spec["DefaultValue"] {
        defaultsToRegister[key] = value
      }
    }

    self.defaults.register(defaults: defaultsToRegister)
  }

  // MARK: - Private Properties

  private let defaults: UserDefaults
  private enum Keys {
    static let shops = "shops"
    static let closingSoonThreshold = "closingSoonThreshold"
  }
}
