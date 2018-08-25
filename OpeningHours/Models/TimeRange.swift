//
//  TimeRange.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct TimeRange {
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
}

extension TimeRange: Codable {
  init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    self.init(
      start: try container.decode(Time.self),
      end: try container.decode(Time.self)
    )
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(self.start)
    try container.encode(self.end)
  }
}

extension TimeRange {
  func intersects(with other: TimeRange) -> Bool {
    return (self.start <= other.end) && (self.end >= other.start)
  }

  func contains(_ time: Time) -> Bool {
    return start <= time && time <= end
  }

  func minutesRemaining(at time: Time = .now) -> Int {
    return self.end.totalMinutes - time.totalMinutes
  }
}

extension TimeRange: CustomStringConvertible {
  var description: String {
    return "\(start) - \(end)"
  }
}
