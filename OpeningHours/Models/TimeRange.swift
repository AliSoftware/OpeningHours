//
//  TimeRange.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct TimeRange: Codable {
  let start: Time
  let end: Time

  init(start: Time, end: Time) {
    assert(start < end, "start must be < to end")
    self.start = start
    self.end = end
  }

  var durationInMinutes: Int {
    return self.end.totalMinutes - self.start.totalMinutes
  }

  func intersects(with other: TimeRange) -> Bool {
    return (self.start <= other.end) && (self.end >= other.start)
  }

  func contains(_ time: Time) -> Bool {
    return start <= time && time <= end
  }
}
