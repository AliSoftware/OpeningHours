//
//  TimeRange.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 25/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

struct TimeRange: Equatable {
  // MARK: - Public Properties

  var start: Time
  var end: Time

  // MARK: - Setup

  init(start: Time, end: Time) {
    assert(start < end, "start must be < to end")
    self.start = start
    self.end = end
  }
}

// MARK: - Public Methods

extension TimeRange {
  var durationInMinutes: Int {
    return self.end.totalMinutes - self.start.totalMinutes
  }

  var isValid: Bool {
    return self.start < self.end
  }

  func intersects(with other: TimeRange) -> Bool {
    return (self.start <= other.end) && (self.end >= other.start)
  }

  func contains(_ time: Time) -> Bool {
    return start <= time && time < end
  }

  static func ~= (range: TimeRange, time: Time) -> Bool {
    return range.contains(time)
  }

  func minutesRemaining(at time: Time = .now) -> Int {
    return self.end.totalMinutes - time.totalMinutes
  }
}

// MARK: - Codable

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

// MARK: - CustomStringConvertible

extension TimeRange: CustomStringConvertible {
  var description: String {
    return "\(start) - \(end)"
  }
}
