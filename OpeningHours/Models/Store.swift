//
//  Store.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

class Store {
  static let main = Store(defaults: .standard)
  private let defaults: UserDefaults
  private static let shopsKey = "shops"

  init(defaults: UserDefaults) {
    self.defaults = defaults
  }

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
}
