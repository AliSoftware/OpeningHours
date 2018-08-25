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

  init(date: Date = Date()) {
    let cal = Calendar.current
    let weekDay = cal.component(.weekday, from: date)
    guard let day = Weekday(rawValue: weekDay) else {
      fatalError("Unsupported Weekday")
    }
    self = day
  }
}

extension Weekday: CustomStringConvertible {
  var description: String {
    let cal = Calendar.current
    guard cal.weekdaySymbols.count == Weekday.allCases.count else {
      return "Unsupported calendar"
    }
    return cal.weekdaySymbols[self.rawValue - 1]
  }
}
