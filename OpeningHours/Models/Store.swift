//
//  Store.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

class Store {
  // MARK: - Public Type Properties

  static let main = Store(defaults: .standard)

  var shops: [Shop] {
    get {
      guard let data = self.defaults.data(forKey: Store.shopsKey) else {
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
    set {
      let encoder = JSONEncoder()
      do {
        let data = try encoder.encode(newValue)
        self.defaults.set(data, forKey: Store.shopsKey)
      } catch {
        print("Unable to encode shops to UserDefaults")
      }
    }
  }

  // MARK: - Setup

  init(defaults: UserDefaults) {
    self.defaults = defaults
  }

  // MARK: - Private Properties

  private let defaults: UserDefaults
  private static let shopsKey = "shops"
}
