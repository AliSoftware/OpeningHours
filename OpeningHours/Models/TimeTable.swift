//
//  TimeTable.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 30/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct TimeTable: Codable {

  // MARK: Public Properties

  var table: [Weekday: [TimeRange]]

  // MARK: - Setup

  init(table: [Weekday: [TimeRange]] = [:]) {
    self.table = table
  }

  // MARK: - Public Methods

  mutating func add(range: TimeRange, for day: Weekday) {
    var ranges = self.table[day] ?? []
    ranges.append(range)
    self.table[day] = ranges.sorted { ($0.start, $0.end) < ($1.start, $1.end) }
  }

  subscript(_ day: Weekday) -> [TimeRange] {
    get {
      return table[day] ?? []
    }
    set {
      table[day] = newValue
    }
  }

  func activeTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    return table[day]?.first(where: { range in range.contains(time) })
  }

  func nextTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    if let nextRange = table[day]?.first(where: { range in range.start >= time }) {
      return nextRange
    }
    return day.next.flatMap { table[$0]?.first }
  }
}

// MARK: - CustomStringConvertible

extension TimeTable: CustomStringConvertible {
  var description: String {
    return table.description
  }
}
