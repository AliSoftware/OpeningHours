//
//  Time.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct Time {
  // MARK: - Public Properties

  var hour: Int
  var minutes: Int

  var totalMinutes: Int {
    return hour * 60 + minutes
  }

  // MARK: - Public Type Properties

  static let max = 24*60
  static var now: Time {
    return Time()
  }

  // MARK: - Setup

  init(hour: Int, minutes: Int) {
    self.hour = hour
    self.minutes = minutes
  }

  init(totalMinutes: Int) {
    self.hour = totalMinutes / 60
    self.minutes = totalMinutes % 60
  }

  init(date: Date = Date()) {
    let cal = Calendar.current
    let comps = cal.dateComponents([.hour, .minute], from: date)
    self.hour = comps.hour ?? 0
    self.minutes = comps.minute ?? 0
  }
}

// MARK: - Codable

extension Time: Codable {
  init(from decoder: Decoder) throws {
    let value = try decoder.singleValueContainer().decode(Int.self)
    self.init(totalMinutes: value)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(self.totalMinutes)
  }
}

// MARK: - CustomStringConvertible

extension Time: CustomStringConvertible {
  var description: String {
    return String(format: "%02dh%02d", hour, minutes)
  }
}

// MARK: - Comparable

extension Time: Comparable {
  static func < (lhs: Time, rhs: Time) -> Bool {
    return lhs.totalMinutes < rhs.totalMinutes
  }

  static func == (lhs: Time, rhs: Time) -> Bool {
    return lhs.totalMinutes == rhs.totalMinutes
  }
}
