//
//  TimeTable.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct Shop: Codable {
  let name: String
  var timeTable: [Weekday: [TimeRange]]

  func isOpen(on day: Weekday = Weekday(), at time: Time = Time()) -> Bool {
    guard let ranges = timeTable[day] else {
      return false
    }
    return ranges.contains { range in range.contains(time) }
  }
}
