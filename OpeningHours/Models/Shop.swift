//
//  TimeTable.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

typealias TimeTable = [Weekday: [TimeRange]]

class Shop: Codable {
  // MARK: - Public Properties

  var name: String
  var timeTable: TimeTable

  // MARK: - Setup

  init(name: String, timeTable: TimeTable = [:]) {
    self.name = name
    self.timeTable = timeTable
  }
  // MARK: - Public Methods

  func activeTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    return timeTable[day]?.first(where: { range in range.contains(time) })
  }

  func nextTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    if let nextRange = timeTable[day]?.first(where: { range in range.start >= time }) {
      return nextRange
    }
    return day.next.flatMap { timeTable[$0]?.first }
  }

  func isOpen(on day: Weekday = .today, at time: Time = .now) -> Bool {
    return activeTimeRange(on: day, at: time) != nil
  }
}

extension Shop: CustomStringConvertible {
  var description: String {
    return "<Shop: \(name)>"
  }
}
