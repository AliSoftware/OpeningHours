//
//  TimeTable.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

typealias TimeTable = [Weekday: [TimeRange]]

struct Shop: Codable {
  var name: String
  var timeTable: TimeTable

  func activeTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    guard let ranges = timeTable[day] else {
      return nil
    }
    return ranges.last(where: { range in range.contains(time) })
  }

  func isOpen(on day: Weekday = .today, at time: Time = .now) -> Bool {
    return activeTimeRange(on: day, at: time) != nil
  }
}
