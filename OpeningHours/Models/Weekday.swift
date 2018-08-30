//
//  Weekday.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

enum Weekday: Int, CaseIterable, Codable {
  case sunday = 1
  case monday = 2
  case tuesday = 3
  case wednesday = 4
  case thursday = 5
  case friday = 6
  case saturday = 7

  // MARK: - Public Type Properties

  static var today: Weekday {
    return Weekday()
  }

  // MARK: - Setup

  init(date: Date = Date()) {
    let cal = Calendar.current
    let weekDay = cal.component(.weekday, from: date)
    guard let day = Weekday(rawValue: weekDay) else {
      fatalError("Unsupported Weekday")
    }
    self = day
  }
}

// MARK: - CustomStringConvertible

extension Weekday: CustomStringConvertible {
  var localizedName: String {
    let cal = Calendar.current
    guard cal.standaloneWeekdaySymbols.count == Weekday.allCases.count else {
      return "Unsupported calendar"
    }
    return cal.standaloneWeekdaySymbols[self.rawValue - 1].capitalized
  }
  var localizedShortName: String {
    let cal = Calendar.current
    guard cal.shortStandaloneWeekdaySymbols.count == Weekday.allCases.count else {
      return "Unsupported calendar"
    }
    return cal.shortStandaloneWeekdaySymbols[self.rawValue - 1].capitalized
  }
  var description: String {
    return localizedName
  }
}

// MARK: -

extension Weekday {
  /// Ordered list of all days according to a given calendar
  static func ordered(calendar: Calendar = .current) -> Weekday.AllCases {
    guard let firstDay = Weekday(rawValue: calendar.firstWeekday) else {
      return allCases
    }
    let all = Weekday.allCases
    let firstIdx = all.firstIndex(of: firstDay) ?? all.startIndex
    return Array(all[firstIdx..<all.endIndex] + all[all.startIndex..<firstIdx])
  }

  var next: Weekday! {
    let all = Weekday.allCases
    return all.firstIndex(of: self)
      .map(all.index(after:))
      .flatMap { all.indices.contains($0) ? all[$0] : all.first }
  }

}
