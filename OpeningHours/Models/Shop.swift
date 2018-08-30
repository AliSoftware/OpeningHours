//
//  TimeTable.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

class Shop: Codable {
  // MARK: - Public Properties

  var name: String
  var timeTable: TimeTable

  // MARK: - Setup

  init(name: String, timeTable: TimeTable = TimeTable()) {
    self.name = name
    self.timeTable = timeTable
  }

  // MARK: - Public Methods

  func isOpen(on day: Weekday = .today, at time: Time = .now) -> Bool {
    return self.timeTable.activeTimeRange(on: day, at: time) != nil
  }
}

extension Shop: CustomStringConvertible {
  var description: String {
    return "<Shop: \(name)>"
  }
}
