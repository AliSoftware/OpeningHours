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
  // MARK: - Public Properties

  var name: String
  var timeTable: TimeTable

  // MARK: - Public Methods

  func activeTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    return timeTable[day]?.first(where: { range in range.contains(time) })
  }

  func nextTimeRange(on day: Weekday = .today, at time: Time = .now) -> TimeRange? {
    if let nextRange = timeTable[day]?.first(where: { range in range.start >= time }) {
      return nextRange
    }
    func cycle<C: Collection>(in collection: C, after element: C.Element) -> C.Element? where C.Element: Equatable {
      return collection.firstIndex(of: element)
        .map(collection.index(after:))
        .flatMap { collection.indices.contains($0) ? collection[$0] : collection.first }
    }
    let nextDay = cycle(in: Weekday.allCases, after: day)
    return nextDay.flatMap { timeTable[$0]?.first }
  }

  func isOpen(on day: Weekday = .today, at time: Time = .now) -> Bool {
    return activeTimeRange(on: day, at: time) != nil
  }
}
