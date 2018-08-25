//
//  Time.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct Time: Codable {
  let hour: Int
  let minutes: Int
  static let max = 24*60

  var totalMinutes: Int {
    return hour * 60 + minutes
  }

  init(hour: Int, minutes: Int) {
    self.hour = hour
    self.minutes = minutes
  }
  
  init(date: Date = Date()) {
    let cal = Calendar.current
    let comps = cal.dateComponents([.hour, .minute], from: date)
    self.hour = comps.hour ?? 0
    self.minutes = comps.minute ?? 0
  }

}

extension Time: Comparable {
  static func < (lhs: Time, rhs: Time) -> Bool {
    return lhs.totalMinutes < rhs.totalMinutes
  }

  static func == (lhs: Time, rhs: Time) -> Bool {
    return lhs.totalMinutes == rhs.totalMinutes
  }
}
